settings = Stash.settings(node)
stash_version = Chef::Version.new(node['stash']['version'])

template "#{node['stash']['install_path']}/stash/bin/setenv.sh" do
  if stash_version < Chef::Version.new('3.8.0')
    source 'setenv.sh.erb'
  else
    source '3.8+/setenv.sh.erb'
  end
  owner node['stash']['user']
  mode '0755'
  notifies :restart, 'service[stash]', :delayed
end

template "#{node['stash']['install_path']}/stash/conf/server.xml" do
  if stash_version.major == 1
    source 'server.xml.erb'
  elsif stash_version >= Chef::Version.new('3.3.0')
    source 'server-tomcat8.xml.erb'
  else
    source 'server-tomcat7.xml.erb'
  end
  owner node['stash']['user']
  mode '0640'
  variables :tomcat => settings['tomcat']
  notifies :restart, 'service[stash]', :delayed
end

template "#{node['stash']['install_path']}/stash/conf/web.xml" do
  if stash_version.major == 1
    source 'web.xml.erb'
  else
    source 'web-tomcat7.xml.erb'
  end
  owner node['stash']['user']
  mode '0644'
  notifies :restart, 'service[stash]', :delayed
end
