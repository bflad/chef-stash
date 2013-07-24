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

default['stash']['run_user']       = "stash"

default['stash']['backup_home']    = true
default['stash']['backup_install'] = true
default['stash']['home_backup']    = "/tmp/atlassian-stash-home-backup.tgz"
default['stash']['home_path']      = "/home/#{node['stash']['run_user']}"
default['stash']['install_backup'] = "/tmp/atlassian-stash-backup.tgz"
default['stash']['install_path']   = "/opt/atlassian-stash"
default['stash']['url_base']       = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash"
default['stash']['version']        = "2.5.0"

default['stash']['url']      = "#{node['stash']['url_base']}-#{node['stash']['version']}.tar.gz"
default['stash']['checksum'] = case node['stash']['version']
when "2.3.1"; "736580eac07e229b165f83600e2c783b5cd54b775be99aeb4a57dee6715ac626"
when "2.4.0"; "f71fd89a5b0364179cd3d50476be8843291fe2629d2a379f6dcc8434ae724a97"
when "2.4.1"; "9b6347e25738b728cce33dce6eb7171be78fa913665b2065b0c9d1c3df4de9e0"
when "2.4.2"; "f7152641addb87ad465ea5d1fa10412bdb095ac7229b8e2f033a2e4e5e0df40c"
when "2.5.0"; "75fdae77d0b671eb34737458b2cae6c150a2a487c8e21df4ce820179b04d11d9"
when "2.5.1"; "5e799d4f049d015eba5e3db8ccfc7dafc8ffd68eabecffd5a4d2430e118892d2"
when "2.5.2"; "6b499626d5ef91dc298c868374ed2afd09deec7b99fdb0cb629afe325b9c6ab7"
when "2.5.3"; "6eb43c7139e5011d4133f8bf773c29d58db459f09f4fdb44ded35dbd20848710"
when "2.6.0"; "c44d89c2728fadc238b577c8d9719af6d4151dd7841a4b0f3335c946358b82b6"
end

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
