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
default['stash']['version']        = "2.8.1"

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
when "2.6.1"; "17ba67a7675e045f89fc83751bcb48c80fa1409c870902e4962eccc288eca7e2"
when "2.6.2"; "65c56c887eaef4ba4b581894b78d5169e3ea247611083c9bf021927b1953cd30"
when "2.6.3"; "7dee2f3331803282379380721de1c6ea307cca210dd01afc1b3cd9630231e042"
when "2.6.4"; "f561ee131977f96bf049ee0b889f4b5905b6ccc2faa36ac5a73c366e3aaaafca"
when "2.7.0"; "e41d1d79ab94d3256c443b66c8536d526f9cba72ac5a190a7b19a83d006c18ee"
when "2.7.1"; "7487c0d7e03256eb3ab027ff744dd5e56b84508b01b17f39afaa1237305939f6"
when "2.7.2"; "9efbd97ff84b74e8fbbe97c97c55df2f4b896ef35d38ec79ad70084c141c570b"
when "2.8.0"; "d7a0af075f0ee3d1290ddbd14ed11be2e4e83b3ebc6414f5655a39e2478af362"
when "2.8.1"; "4282f05f76fce2104e76c972a4d46092020e3e90894537e06c739df9c6680437"
end

default['stash']['backup_client']['backup_path']  = "/tmp"
default['stash']['backup_client']['baseurl']      = "https://#{node['fqdn']}/"
default['stash']['backup_client']['install_path'] = "/opt/atlassian-stash-backup-client"
default['stash']['backup_client']['password']     = "changeit"
default['stash']['backup_client']['url_base']     = "http://downloads.atlassian.com/software/stash/downloads/stash-backup-client"
default['stash']['backup_client']['user']         = "admin"
default['stash']['backup_client']['version']      = "1.0.0"

default['stash']['backup_client']['url']      = "#{node['stash']['backup_client']['url_base']}-#{node['stash']['backup_client']['version']}.zip"
default['stash']['backup_client']['checksum'] = case node['stash']['backup_client']['version']
when "1.0.0-beta-11"; "b1ec42ef96db0cbb3f5678c75da119019d8894c3b09ee886ced075c694bbafb2"
when "1.0.0"; "a3c063ac04c484d9a5d36de68a1162e9869f08c4703cc1241157738cf17dc92e"
end

default['stash']['backup_client']['cron']['day'] = "*"
default['stash']['backup_client']['cron']['hour'] = "0"
default['stash']['backup_client']['cron']['minute'] = "0"
default['stash']['backup_client']['cron']['month'] = "*"
default['stash']['backup_client']['cron']['weekday'] = "*"

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
