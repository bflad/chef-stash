#
# Cookbook Name:: stash
# Attributes:: stash
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

default['stash']['version']        = "1.3.0"
default['stash']['url']            = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-#{node['stash']['version']}.tar.gz"
default['stash']['checksum']       = "2731997d6e223cb512906183f5c231be602319ce05d2794cdf5b957a1fd06e08"
default['stash']['backup_home']    = true
default['stash']['backup_install'] = true
default['stash']['install_backup'] = "/tmp/atlassian-stash-backup.tgz"
default['stash']['install_path']   = "/opt/atlassian-stash"
default['stash']['run_user']       = "stash"
default['stash']['home_backup']    = "/tmp/atlassian-stash-home-backup.tgz"
default['stash']['home_path']      = "/home/#{node['stash']['run_user']}"

default['stash']['jvm']['minimum_memory']  = "256m"
default['stash']['jvm']['maximum_memory']  = "768m"
default['stash']['jvm']['maximum_permgen'] = "256m"
default['stash']['jvm']['java_opts']       = ""
default['stash']['jvm']['support_args']    = ""

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port'] = "7999"
default['stash']['ssh']['uri']  = "ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}"

default['stash']['tomcat']['port']     = "7990"
default['stash']['tomcat']['ssl_port'] = "8443"
