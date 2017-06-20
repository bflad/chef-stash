# frozen_string_literal: true

stash_version = Chef::Version.new(node['stash']['version'])
server_xml_path = "#{node['stash']['install_path']}/stash/conf/server.xml"

if stash_version >= Chef::Version.new('3.8.0')
  server_xml_path = "#{node['stash']['home_path']}/shared/server.xml"
end

if stash_version < Chef::Version.new('5.0.0')

  template "#{node['stash']['install_path']}/#{node['stash']['product']}/bin/setenv.sh" do
    if stash_version < Chef::Version.new('3.8.0')
      source 'setenv.sh.erb'
    elsif node['stash']['product'] == 'stash'
      source '3.8+/setenv.sh.erb'
    else
      source 'bitbucket/setenv.sh.erb'
    end
    owner node['stash']['user']
    mode '0755'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end

  template server_xml_path do
    if stash_version.major == 1
      source 'server.xml.erb'
    elsif stash_version < Chef::Version.new('3.3.0')
      source 'server-tomcat7.xml.erb'
    elsif stash_version < Chef::Version.new('3.8.0')
      source 'server-tomcat8.xml.erb'
    elsif node['stash']['product'] == 'stash'
      source '3.8+/server.xml.erb'
    else
      source 'bitbucket/server.xml.erb'
    end
    owner node['stash']['user']
    mode '0640'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end

  template "#{node['stash']['install_path']}/#{node['stash']['product']}/conf/web.xml" do
    if stash_version.major == 1
      source 'web.xml.erb'
    elsif stash_version < Chef::Version.new('3.8.0')
      source 'web-tomcat7.xml.erb'
    elsif node['stash']['product'] == 'stash'
      source '3.8+/web.xml'
    else
      source 'bitbucket/web.xml'
    end
    owner node['stash']['user']
    mode '0644'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end
else
  template "#{node['stash']['install_path']}/bitbucket/bin/_start-webapp.sh" do
    source 'bitbucket5/_start-webapp.sh.erb'
    owner node['stash']['user']
    mode '0755'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end
end

directory "/var/run/#{node['stash']['product']}" do
  owner node['stash']['user']
  group node['stash']['user']
  mode '0755'
  action :create
end

user_sh = 'user.sh'
if stash_version >= Chef::Version.new('4.6.0')
  user_sh = 'set-bitbucket-user.sh'

  template "#{node['stash']['install_path']}/bitbucket/bin/set-bitbucket-home.sh" do
    source 'bitbucket/set-bitbucket-home.sh.erb'
    owner node['stash']['user']
    mode '0755'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end
end

template "#{node['stash']['install_path']}/bitbucket/bin/#{user_sh}" do
  source 'bitbucket/user.sh.erb'
  owner node['stash']['user']
  mode '0755'
  notifies :restart, "service[#{node['stash']['product']}]", :delayed
  only_if { node['stash']['product'] == 'bitbucket' }
end
