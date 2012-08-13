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

#if node[:stash][:database] == "postgresql" && node[:stash][:database_host] == "localhost"  
#  include_recipe "database"
#  database_connection = {:host => "#{node[:stash][:database_host]}", :port => node[:stash][:database_port], :username => 'postgres', :password => node[:postgresql][:password][:postgres]}
#  database_info = Chef::EncryptedDataBagItem.load("stash","stash")
#
#  postgresql_database database_info[node.chef_environment]["database"] do
#    connection database_connection
#    action :create
#  end
#
#  postgresql_database_user database_info[node.chef_environment]["database_user"] do
#    connection database_connection
#    password database_info[node.chef_environment]["database_password"]
#    database_name database_info[node.chef_environment]["database"]
#    action [:create, :grant]
#  end
#end

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
    mv atlassian-stash-#{node[:stash][:version]} #{node[:stash][:install_path]}
  COMMAND
  not_if "test -f #{node[:stash][:install_path]}/atlassian-stash.war"
end

user node[:stash][:run_user] do
  comment "Stash Service Account"
  shell   "/bin/bash"
  system  true
  action  :create 
end

directory "#{node[:stash][:install_path]}" do
  recursive true
  owner     node[:stash][:run_user]
end

template "#{node[:stash][:install_path]}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner  node[:stash][:run_user]
  mode   "0755"
end

template "#{node[:stash][:install_path]}/conf/server.xml.erb" do
  source "server.xml.erb"
  owner  node[:stash][:run_user]
  mode   "0640"
end

template "#{node[:stash][:install_path]}/conf/web.xml" do
  source "web.xml"
  owner  node[:stash][:run_user]
  mode   "0644"
end
