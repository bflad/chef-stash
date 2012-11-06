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

service "Stopping Stash" do
  service_name "stash"
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

directory node['stash']['install_path'] do
  recursive true
  action :delete
end

include_recipe "stash"

ruby_block "remove_recipe_stash_upgrade" do
  block { node.run_list.remove("recipe[stash::upgrade]") }
end
