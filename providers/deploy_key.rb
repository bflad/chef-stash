#
# Cookbook Name:: stash
# Provider:: deploy_key
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

action :create do
  key_path = "#{node['stash']['install_path']}/#{new_resource.alias}_ssh_key.pem"
  wrapper_path = "#{node['stash']['install_path']}/#{new_resource.alias}_ssh_wrapper.sh"

  directory node['stash']['install_path'] do
    owner 'root'
    group 'root'
    mode 0755
    action :create
    not_if { ::File.exists?(node['stash']['install_path']) }
  end

  file key_path do
    owner new_resource.owner
    mode 0400
    content new_resource.key
    action :create
  end
  
  template wrapper_path do
    source 'ssh_wrapper.sh.erb'
    cookbook 'stash'
    owner new_resource.owner
    mode 0500
    variables( :key_path => key_path )
  end

  new_resource.updated_by_last_action(true)
end