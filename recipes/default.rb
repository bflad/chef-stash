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

stash_data_bag = Chef::EncryptedDataBagItem.load("stash","stash")
stash_configuration_info = stash_data_bag[node.chef_environment]['configuration']
stash_database_info = stash_data_bag[node.chef_environment]['database']
stash_tomcat_info = stash_data_bag[node.chef_environment]['tomcat']

case stash_database_info['type']
when "mysql"
  stash_database_info['port'] ||= "3306"
  stash_database_info['provider'] = Chef::Provider::Database::Mysql
when "postgresql"
  stash_database_info['port'] ||= "5432"
  stash_database_info['provider'] = Chef::Provider::Database::Postgresql
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
    database_connection << { :username => 'root', :password => node[:mysql][:server_root_password] }
  when "postgresql"
    # Temporary handling of pg for COOK-1406
    chef_gem "pg"
    
    include_recipe "postgresql::server"
    database_connection << { :username => 'postgres', :password => node[:postgresql][:password][:postgres] }
  end
  
  database stash_database_info['name'] do
    connection database_connection
    provider stash_database_info['provider']
    encoding "utf8"
    case stash_database_info['type']
    when "mysql"
      collation "ut8_bin"
    when "postgresql"
      connection_limit "-1"
    end
    action :create
  end

  database_user stash_database_info['user'] do
    connection database_connection
    provider stash_database_info['provider']
    password stash_database_info['password']
    database_name stash_database_info['name']
    action [:create, :grant]
  end
end

user node[:stash][:run_user] do
  comment "Stash Service Account"
  home    node[:stash][:home_path]
  shell   "/bin/bash"
  system  true
  action  :create 
end

execute "Generating Self-Signed Java Keystore" do
  command <<-COMMAND
    #{node[:java][:java_home]}/bin/keytool -genkey \
      -alias tomcat \
      -keyalg RSA \
      -dname 'CN=#{node[:fqdn]}, OU=Example, O=Example, L=Example, ST=Example, C=US' \
      -keypass changeit \
      -storepass changeit \
      -keystore #{node[:stash][:home_path]}/.keystore
    chown #{node[:stash][:run_user]}:#{node[:stash][:run_user]} #{node[:stash][:home_path]}/.keystore
  COMMAND
  creates "#{node[:stash][:home_path]}/.keystore"
end

remote_file "#{Chef::Config[:file_cache_path]}/atlassian-stash-#{node[:stash][:version]}.tar.gz" do
  source    node[:stash][:url]
  checksum  node[:stash][:checksum]
  mode      "0644"
  action    :create_if_missing
end

execute "Extracting Stash #{node[:stash][:version]}" do
  cwd Chef::Config[:file_cache_path]
  command <<-COMMAND
    tar -zxf atlassian-stash-#{node[:stash][:version]}.tar.gz
    chown -R #{node[:stash][:run_user]} atlassian-stash-#{node[:stash][:version]}
    mv atlassian-stash-#{node[:stash][:version]} #{node[:stash][:install_path]}
  COMMAND
  creates "#{node[:stash][:install_path]}/atlassian-stash.war"
end

if stash_database_info['type'] == "mysql"
  remote_file "#{Chef::Config[:file_cache_path]}/mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}.tar.gz" do
    source    node[:stash][:mysql][:connector][:url]
    checksum  node[:stash][:mysql][:connector][:checksum]
    mode      "0644"
    action    :create_if_missing
  end

  execute "Extracting MySQL Connector Java #{node[:stash][:mysql][:connector][:version]}" do
    cwd Chef::Config[:file_cache_path]
    command <<-COMMAND
      tar -zxf mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}.tar.gz
      chown -R #{node[:stash][:run_user]} mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}
      mv mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}/mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}-bin.jar #{node[:stash][:install_path]}/lib
    COMMAND
    creates "#{node[:stash][:install_path]}/lib/mysql-connector-java-#{node[:stash][:mysql][:connector][:version]}-bin.jar"
  end
end

template "#{node[:stash][:install_path]}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner  node[:stash][:run_user]
  mode   "0755"
  notifies :restart, resources(:service => "stash"), :delayed
end

template "#{node[:stash][:install_path]}/conf/server.xml" do
  source "server.xml.erb"
  owner  node[:stash][:run_user]
  mode   "0640"
  variables :tomcat => stash_tomcat_info
  notifies :restart, resources(:service => "stash"), :delayed
end

template "#{node[:stash][:install_path]}/conf/web.xml" do
  source "web.xml"
  owner  node[:stash][:run_user]
  mode   "0644"
  notifies :restart, resources(:service => "stash"), :delayed
end

template "#{node[:stash][:install_path]}/stash-config.properties" do
  source "stash-config.properties.erb"
  owner  node[:stash][:run_user]
  mode   "0644"
  variables :database => stash_database_info
  notifies :restart, resources(:service => "stash"), :delayed
end

template "/etc/init.d/stash" do
  source "stash.init.erb"
  mode   "0755"
end

service "stash" do
  supports :status => true, :restart => true
  action [:enable, :start]
end

database_connection = {
  :host => stash_database_info['host'],
  :port => stash_database_info['port'],
  :username => stash_database_info['user'],
  :password => stash_database_info['password']
}

#database stash_database_info['name'] do
#  connection database_connection
#  provider stash_database_info['provider']
#  sql "INSERT INTO app_property ('prop_key','prop_value') VALUES ('instance.url','https://#{node[:fqdn]}')"
#  action :query
#  ignore_failure true
#end

#if stash_configuration_info && stash_configuration_info['license']
#  database stash_database_info['name'] do
#    connection database_connection
#    provider stash_database_info['provider']
#    sql "INSERT INTO app_property ('prop_key','prop_value') VALUES ('license','#{stash_configuration_info['license']}')"
#    action :query
#    ignore_failure true
#  end
#end
