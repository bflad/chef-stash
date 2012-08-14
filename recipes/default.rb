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

stash_data_bag = Chef::EncryptedDataBagItem.load("stash","stash")
stash_database_info = stash_data_bag[node.chef_environment]['database']
stash_tomcat_info = stash_data_bag[node.chef_environment]['tomcat']

case stash_database_info['type']
when "mysql"
  stash_database_info['port'] ||= "3306"
  
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
when "postgresql"
  stash_database_info['port'] ||= "5432"
end

if stash_database_info['host'] == "localhost"
  case stash_database_info['type']
  when "mysql"
    # Documentation: https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+MySQL
    include_recipe "mysql::server"
    include_recipe "database"
    database_connection = {
      :host => stash_database_info['host'],
      :port => stash_database_info['port'],
      :username => 'root',
      :password => node[:mysql][:server_root_password]
    }

    mysql_database stash_database_info['name'] do
      connection database_connection
      encoding "utf8"
      collation "ut8_bin"
      action :create
    end

    mysql_database_user stash_database_info['user'] do
      connection database_connection
      password stash_database_info['password']
      database_name stash_database_info['name']
      action [:create, :grant]
    end
  when "postgresql"
    # Documentation: https://confluence.atlassian.com/display/STASH/Connecting+Stash+to+PostgreSQL
    # Temporary handling of pg for COOK-1406
    chef_gem "pg"

    include_recipe "postgresql::server"
    include_recipe "database"
    database_connection = {
      :host => stash_database_info['host'],
      :port => stash_database_info['port'],
      :username => 'postgres',
      :password => node[:postgresql][:password][:postgres]
    }

    postgresql_database stash_database_info['name'] do
      connection database_connection
      connection_limit "-1"
      encoding "utf8"
      action :create
    end

    postgresql_database_user stash_database_info['user'] do
      connection database_connection
      password stash_database_info['password']
      database_name stash_database_info['name']
      action [:create, :grant]
    end
  else
    Chef::Log.warn("Unsupported database type for localhost database creation. Skipping.")
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

template "#{node[:stash][:install_path]}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner  node[:stash][:run_user]
  mode   "0755"
end

template "#{node[:stash][:install_path]}/conf/server.xml" do
  source "server.xml.erb"
  owner  node[:stash][:run_user]
  mode   "0640"
  variables :tomcat => stash_tomcat_info
end

template "#{node[:stash][:install_path]}/conf/web.xml" do
  source "web.xml"
  owner  node[:stash][:run_user]
  mode   "0644"
end

template "#{node[:stash][:install_path]}/stash-config.properties" do
  source "stash-config.properties.erb"
  owner  node[:stash][:run_user]
  mode   "0644"
  variables :database => stash_database_info
end

template "/etc/init.d/stash" do
  source "stash.init.erb"
  mode   "0755"
end

service "stash" do
  supports :restart => true
  action [:enable, :start]
end
