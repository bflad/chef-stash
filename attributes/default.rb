#
# Cookbook Name:: stash
# Attributes:: stash
#
# Copyright 2012-2013
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

set['build_essential']['compiletime'] = true

default['stash']['version']        = "2.2.0"
default['stash']['url']            = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash-#{node['stash']['version']}.tar.gz"
default['stash']['checksum']       = "3e8a461f30dbb6bd31a0d9aa42d639a147a3da2b9c534e7923eccca4169bf052"
default['stash']['backup_home']    = true
default['stash']['backup_install'] = true
default['stash']['install_backup'] = "/tmp/atlassian-stash-backup.tgz"
default['stash']['install_path']   = "/opt/atlassian-stash"
default['stash']['run_user']       = "stash"
default['stash']['home_backup']    = "/tmp/atlassian-stash-home-backup.tgz"
default['stash']['home_path']      = "/home/#{node['stash']['run_user']}"

default['stash']['database']['host']     = "localhost"
default['stash']['database']['name']     = "stash"
default['stash']['database']['password'] = "changeit"
default['stash']['database']['port']     = 3306
default['stash']['database']['type']     = "mysql"
default['stash']['database']['user']     = "stash"

default['stash']['jvm']['minimum_memory']  = "512m"
default['stash']['jvm']['maximum_memory']  = "768m"
default['stash']['jvm']['maximum_permgen'] = "256m"
default['stash']['jvm']['java_opts']       = ""
default['stash']['jvm']['support_args']    = ""

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port']     = "7999"

default['stash']['tomcat']['keyAlias']     = "tomcat"
default['stash']['tomcat']['keystoreFile'] = "#{node['stash']['home_path']}/.keystore"
default['stash']['tomcat']['keystorePass'] = "changeit"
default['stash']['tomcat']['port']         = "7990"
default['stash']['tomcat']['ssl_port']     = "8443"
