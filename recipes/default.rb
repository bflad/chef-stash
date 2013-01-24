#
# Cookbook Name:: stash
# Recipe:: default
#
# Copyright 2012
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe "git::source" if node['platform_family'] == "rhel"

settings = Stash.settings(node)

if settings['database']['host'] == "localhost"
  database_connection = {
    :host => settings['database']['host'],
    :port => settings['database']['port']
  }

  case settings['database']['type']
  when "mysql"
    include_recipe "mysql::server"
    include_recipe "database::mysql"
    database_connection.merge!({ :username => 'root', :password => node['mysql']['server_root_password'] })
    
    mysql_database settings['database']['name'] do
      connection database_connection
      collation "utf8_bin"
      encoding "utf8"
      action :create
    end

    # See this MySQL bug: http://bugs.mysql.com/bug.php?id=31061
    mysql_database_user "" do
      connection database_connection
      host "localhost"
      action :drop
    end

    mysql_database_user settings['database']['user'] do
      connection database_connection
      host "%"
      password settings['database']['password']
      database_name settings['database']['name']
      action [:create, :grant]
    end
  when "postgresql"
    include_recipe "postgresql::server"
    include_recipe "database::postgresql"
    database_connection.merge!({ :username => 'postgres', :password => node['postgresql']['password']['postgres'] })
    
    postgresql_database settings['database']['name'] do
      connection database_connection
      connection_limit "-1"
      encoding "utf8"
      action :create
    end

    postgresql_database_user settings['database']['user'] do
      connection database_connection
      password settings['database']['password']
      database_name settings['database']['name']
      action [:create, :grant]
    end
  end
end

user node['stash']['run_user'] do
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
    chown #{node['stash']['run_user']}:#{node['stash']['run_user']} #{settings['tomcat']['keystoreFile']}
  COMMAND
  creates settings['tomcat']['keystoreFile']
  only_if { settings['tomcat']['keystoreFile'] == "#{node['stash']['home_path']}/.keystore" }
end

remote_file "#{Chef::Config[:file_cache_path]}/atlassian-stash-#{node['stash']['version']}.tar.gz" do
  source    node['stash']['url']
  checksum  node['stash']['checksum']
  mode      "0644"
  action    :create_if_missing
end

execute "Extracting Stash #{node['stash']['version']}" do
  cwd Chef::Config[:file_cache_path]
  command <<-COMMAND
    tar -zxf atlassian-stash-#{node['stash']['version']}.tar.gz
    chown -R #{node['stash']['run_user']} atlassian-stash-#{node['stash']['version']}
    mv atlassian-stash-#{node['stash']['version']} #{node['stash']['install_path']}
  COMMAND
  creates "#{node['stash']['install_path']}/atlassian-stash"
end

if settings['database']['type'] == "mysql"
  include_recipe "mysql_connector"
  mysql_connector_j "#{node['stash']['install_path']}/lib"
end

template "/etc/init.d/stash" do
  source "stash.init.erb"
  mode   "0755"
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['install_path']}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner  node['stash']['run_user']
  mode   "0755"
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['install_path']}/conf/server.xml" do
  source "server.xml.erb"
  owner  node['stash']['run_user']
  mode   "0640"
  variables :tomcat => settings['tomcat']
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['install_path']}/conf/web.xml" do
  source "web.xml.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['home_path']}/stash-config.properties" do
  source "stash-config.properties.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  variables :database => settings['database']
  notifies :restart, "service[stash]", :delayed
end

service "stash" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
  subscribes :restart, resources("java_ark[jdk]")
end
