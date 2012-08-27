#
# Cookbook Name:: stash
# Recipe:: apache2
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

include_recipe "stash"

node['apache']['listen_ports'] << node['stash']['apache2']['port'] unless node['apache']['listen_ports'].include?(node['stash']['apache2']['port'])
node['apache']['listen_ports'] << node['stash']['apache2']['ssl']['port'] unless node['apache']['listen_ports'].include?(node['stash']['apache2']['ssl']['port'])

node['apache']['default_site_enabled'] = false if node['stash']['apache2']['virtual_host_alias'] == node['fqdn']

include_recipe "apache2"
include_recipe "apache2::mod_proxy"
include_recipe "apache2::mod_proxy_http"
include_recipe "apache2::mod_ssl"

template "#{node['apache']['dir']}/sites-available/#{node['stash']['apache2']['virtual_host_name']}.conf" do
  source "apache2.conf.erb"
  mode 0644
  notifies :restart, resources(:service => "apache2")
end

apache_site "#{node['stash']['apache2']['virtual_host_name']}.conf"
