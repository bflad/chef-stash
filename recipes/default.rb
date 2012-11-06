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

include_recipe "database"
include_recipe "git::source" if node['platform_family'] == "rhel"

stash_data_bag = Chef::EncryptedDataBagItem.load("stash","stash")
stash_configuration_info = stash_data_bag[node.chef_environment]['configuration']
stash_database_info = stash_data_bag[node.chef_environment]['database']
stash_tomcat_info = stash_data_bag[node.chef_environment]['tomcat']

case stash_database_info['type']
when "mysql"
  stash_database_info['port'] ||= 3306
  stash_database_info['provider'] = Chef::Provider::Database::Mysql
  stash_database_info['provider_user'] = Chef::Provider::Database::MysqlUser
when "postgresql"
  stash_database_info['port'] ||= 5432
  stash_database_info['provider'] = Chef::Provider::Database::Postgresql
  stash_database_info['provider_user'] = Chef::Provider::Database::PostgresqlUser
else
  Chef::Log.warn("Unsupported database type.")
end

if stash_database_info['host'] == "localhost"
  database_connection = {
    :host => stash_database_info['host'],
    :port => stash_database_info['port']
  }

  case stash_database_info['type']
  when "mysql"
    include_recipe "mysql::server"
    include_recipe "database::mysql"
    database_connection.merge!({ :username => 'root', :password => node['mysql']['server_root_password'] })
  when "postgresql"
    include_recipe "postgresql::server"
    include_recipe "database::postgresql"
    database_connection.merge!({ :username => 'postgres', :password => node['postgresql']['password']['postgres'] })
  end
  
  database stash_database_info['name'] do
    connection database_connection
    provider stash_database_info['provider']
    case stash_database_info['type']
    when "mysql"
      collation "utf8_bin"
    when "postgresql"
      connection_limit "-1"
    end
    encoding "utf8"
    action :create
  end

  database_user stash_database_info['user'] do
    connection database_connection
    provider stash_database_info['provider_user']
    host "%" if stash_database_info['type'] == "mysql"
    password stash_database_info['password']
    database_name stash_database_info['name']
    action [:create, :grant]
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
      -alias tomcat \
      -keyalg RSA \
      -dname 'CN=#{node['fqdn']}, OU=Example, O=Example, L=Example, ST=Example, C=US' \
      -keypass changeit \
      -storepass changeit \
      -keystore #{node['stash']['home_path']}/.keystore
    chown #{node['stash']['run_user']}:#{node['stash']['run_user']} #{node['stash']['home_path']}/.keystore
  COMMAND
  creates "#{node['stash']['home_path']}/.keystore"
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

if stash_database_info['type'] == "mysql"
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
  variables :tomcat => stash_tomcat_info
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['install_path']}/conf/web.xml" do
  source "web.xml.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  notifies :restart, "service[stash]", :delayed
end

template "#{node['stash']['install_path']}/stash-config.properties" do
  source "stash-config.properties.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  variables :database => stash_database_info
  notifies :restart, "service[stash]", :delayed
end

service "stash" do
  supports :status => true, :restart => true
  action [ :enable, :start ]
  subscribes :restart, resources("java_ark[jdk]")
end
