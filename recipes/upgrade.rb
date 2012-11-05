#
# Cookbook Name:: stash
# Recipe:: upgrade
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

#
# Stash Upgrade Guide:
# https://confluence.atlassian.com/display/STASH/Stash+upgrade+guide
#

stash_data_bag = Chef::EncryptedDataBagItem.load("stash","stash")
stash_configuration_info = stash_data_bag[node.chef_environment]['configuration']
stash_database_info = stash_data_bag[node.chef_environment]['database']
stash_tomcat_info = stash_data_bag[node.chef_environment]['tomcat']

service "stash" do
  action :stop
end

execute "Backing up Stash Home Directory" do
  command "tar -zcf #{node['stash']['home_backup']} #{node['stash']['home_path']}"
  only_if { node['stash']['backup_home'] }
end

execute "Backing up Stash Install Directory" do
  command "tar -zcf #{node['stash']['install_backup']} #{node['stash']['install_path']}"
  only_if { node['stash']['backup_install'] }
end

remote_file "#{Chef::Config[:file_cache_path]}/atlassian-stash-#{node['stash']['version']}.tar.gz" do
  source    node['stash']['url']
  checksum  node['stash']['checksum']
  mode      "0644"
  action    :create_if_missing
end

execute "Extracting Stash #{node['stash']['version']} for Upgrade" do
  cwd Chef::Config[:file_cache_path]
  command <<-COMMAND
    tar -zxf atlassian-stash-#{node['stash']['version']}.tar.gz
    chown -R #{node['stash']['run_user']} atlassian-stash-#{node['stash']['version']}
    rm -rf #{node['stash']['install_path']}
    mv atlassian-stash-#{node['stash']['version']} #{node['stash']['install_path']}
  COMMAND
end

if stash_database_info['type'] == "mysql"
  remote_file "#{Chef::Config[:file_cache_path]}/mysql-connector-java-#{node['stash']['mysql']['connector']['version']}.tar.gz" do
    source    node['stash']['mysql']['connector']['url']
    checksum  node['stash']['mysql']['connector']['checksum']
    mode      "0644"
    action    :create_if_missing
  end

  execute "Extracting MySQL Connector Java #{node['stash']['mysql']['connector']['version']}" do
    cwd Chef::Config[:file_cache_path]
    command <<-COMMAND
      tar -zxf mysql-connector-java-#{node['stash']['mysql']['connector']['version']}.tar.gz
      chown -R #{node['stash']['run_user']} mysql-connector-java-#{node['stash']['mysql']['connector']['version']}
      mv mysql-connector-java-#{node['stash']['mysql']['connector']['version']}/mysql-connector-java-#{node['stash']['mysql']['connector']['version']}-bin.jar #{node['stash']['install_path']}/lib
    COMMAND
    creates "#{node['stash']['install_path']}/lib/mysql-connector-java-#{node['stash']['mysql']['connector']['version']}-bin.jar"
  end
end

template "#{node['stash']['install_path']}/bin/setenv.sh" do
  source "setenv.sh.erb"
  owner  node['stash']['run_user']
  mode   "0755"
end

template "#{node['stash']['install_path']}/conf/server.xml" do
  source "server.xml.erb"
  owner  node['stash']['run_user']
  mode   "0640"
  variables :tomcat => stash_tomcat_info
end

template "#{node['stash']['install_path']}/conf/web.xml" do
  source "web.xml.erb"
  owner  node['stash']['run_user']
  mode   "0644"
end

template "#{node['stash']['install_path']}/stash-config.properties" do
  source "stash-config.properties.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  variables :database => stash_database_info
end

service "stash" do
  action :start
end

ruby_block "remove_recipe_stash_upgrade" do
  block { node.run_list.remove("recipe[stash::upgrade]") }
end
