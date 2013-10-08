settings = Stash.settings(node)

directory File.dirname(node['stash']['home_path']) do
  owner "root"
  group "root"
  mode 00755
  action :create
  recursive true
end

user node['stash']['user'] do
  comment "Stash Service Account"
  home    node['stash']['home_path']
  shell   "/bin/bash"
  supports :manage_home => true
  system  true
  action  :create 
end

execute "Generating Self-Signed Java Keystore" do
  command <<-COMMAND
    #{node['java']['java_home']}/bin/keytool -genkey \
      -alias #{settings['tomcat']['keyAlias']} \
      -keyalg RSA \
      -dname 'CN=#{node['fqdn']}, OU=Example, O=Example, L=Example, ST=Example, C=US' \
      -keypass #{settings['tomcat']['keystorePass']} \
      -storepass #{settings['tomcat']['keystorePass']} \
      -keystore #{settings['tomcat']['keystoreFile']}
    chown #{node['stash']['user']}:#{node['stash']['user']} #{settings['tomcat']['keystoreFile']}
  COMMAND
  creates settings['tomcat']['keystoreFile']
  only_if { settings['tomcat']['keystoreFile'] == "#{node['stash']['home_path']}/.keystore" }
end

directory node['stash']['install_path'] do
  owner "root"
  group "root"
  mode 00755
  action :create
  recursive true
end

# remote_file "#{Chef::Config[:file_cache_path]}/atlassian-stash-#{node['stash']['version']}.tar.gz" do
#   source    node['stash']['url']
#   checksum  node['stash']['checksum']
#   mode      "0644"
#   action    :create_if_missing
# end

# execute "Extracting Stash #{node['stash']['version']}" do
#   cwd Chef::Config[:file_cache_path]
#   command <<-COMMAND
#     tar -zxf atlassian-stash-#{node['stash']['version']}.tar.gz
#     mv atlassian-stash-#{node['stash']['version']} #{node['stash']['install_path']}
#     chown -R #{node['stash']['user']} #{node['stash']['install_path']}
#   COMMAND
#   creates "#{node['stash']['install_path']}/atlassian-stash"
# end

ark "stash" do
  url         node['stash']['url']
  prefix_root node['stash']['install_path']
  prefix_home node['stash']['install_path']
  checksum    node['stash']['checksum']
  version     node['stash']['version']
  owner       node['stash']['user']
  group       node['stash']['user']
end

if settings['database']['type'] == "mysql"
  directory "#{node['stash']['home_path']}/lib" do
    owner node['stash']['user']
    group node['stash']['user']
    mode 00755
    action :create
  end
  
  mysql_connector_j "#{node['stash']['home_path']}/lib"
end
