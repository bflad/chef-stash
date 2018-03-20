# frozen_string_literal: true

set['build-essential']['compile_time'] = true

default['stash']['version']      = '5.9.0'
default['stash']['product']      = Chef::Version.new(node['stash']['version']) >= Chef::Version.new('4.0.0') ? 'bitbucket' : 'stash'

default['stash']['home_path'] = if Dir.exist?('/var/atlassian/application-data/stash')
                                  '/var/atlassian/application-data/stash'
                                else
                                  "/var/atlassian/application-data/#{node['stash']['product']}"
                                end

default['stash']['install_path'] = '/opt/atlassian'
default['stash']['install_type'] = 'standalone'
default['stash']['service_type'] = 'init'
default['stash']['url_base']     = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-#{node['stash']['product']}"
default['stash']['user']         = node['stash']['product']

default['stash']['url']      = nil
default['stash']['checksum'] = nil
# sets the IP version which will be used for internal routing. IPv4 will be used if this attribute
# is set to 4, in ANY other cases IPv6 will be used instead
default['stash']['ipversion'] = 4

# Data bag where credentials and other sensitive data could be stored (optional)
default['stash']['data_bag_name'] = 'stash'
default['stash']['data_bag_item'] = 'stash'

default['stash']['apache2']['access_log']         = ''
default['stash']['apache2']['error_log']          = ''
default['stash']['apache2']['port']               = 80
default['stash']['apache2']['virtual_host_alias'] = node['fqdn']
default['stash']['apache2']['virtual_host_name']  = node['hostname']

default['stash']['apache2']['ssl']['access_log']       = ''
default['stash']['apache2']['ssl']['chain_file']       = ''
default['stash']['apache2']['ssl']['error_log']        = ''
default['stash']['apache2']['ssl']['port']             = 443

case node['platform_family']
when 'rhel'
  default['stash']['apache2']['ssl']['certificate_file'] = '/etc/pki/tls/certs/localhost.crt'
  default['stash']['apache2']['ssl']['key_file']         = '/etc/pki/tls/private/localhost.key'
else
  default['stash']['apache2']['ssl']['certificate_file'] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  default['stash']['apache2']['ssl']['key_file']         = '/etc/ssl/private/ssl-cert-snakeoil.key'
end

default['stash']['backup']['strategy'] = 'backup_client'

default['stash']['backup']['backup_path'] = '/tmp'
default['stash']['backup']['baseurl']     = "https://#{node['fqdn']}/"
default['stash']['backup']['password']    = 'changeit'
default['stash']['backup']['user']        = 'admin'

default['stash']['backup']['cron']['enable'] = false
default['stash']['backup']['cron']['day'] = '*'
default['stash']['backup']['cron']['hour'] = '0'
default['stash']['backup']['cron']['minute'] = '0'
default['stash']['backup']['cron']['month'] = '*'
default['stash']['backup']['cron']['weekday'] = '*'

default['stash']['backup_client']['install_path'] = node['stash']['install_path']
default['stash']['backup_client']['version']      = '3.3.4'
stash_backup_client_version = Chef::Version.new(node['stash']['backup_client']['version'])

default['stash']['backup_client']['url_base'] =
  if stash_backup_client_version <= Chef::Version.new('1.2.1')
    'http://downloads.atlassian.com/software/stash/downloads/stash-backup-client'
  elsif stash_backup_client_version < Chef::Version.new('2.0.0')
    'https://maven.atlassian.com/public/com/atlassian/stash/backup/stash-backup-distribution/'
  else
    'https://maven.atlassian.com/repository/public/com/atlassian/bitbucket/server/backup/bitbucket-backup-distribution/'
  end

default['stash']['backup_client']['url'] =
  if stash_backup_client_version <= Chef::Version.new('1.2.1')
    "#{node['stash']['backup_client']['url_base']}-#{node['stash']['backup_client']['version']}.zip"
  elsif stash_backup_client_version < Chef::Version.new('2.0.0')
    "#{node['stash']['backup_client']['url_base']}/#{node['stash']['backup_client']['version']}/stash-backup-distribution-#{node['stash']['backup_client']['version']}.zip"
  else
    "#{node['stash']['backup_client']['url_base']}/#{node['stash']['backup_client']['version']}/bitbucket-backup-distribution-#{node['stash']['backup_client']['version']}.zip"
  end

default['stash']['backup_client']['checksum'] =
  case node['stash']['backup_client']['version']
  when '1.0.0-beta-11' then 'b1ec42ef96db0cbb3f5678c75da119019d8894c3b09ee886ced075c694bbafb2'
  when '1.0.0' then 'a3c063ac04c484d9a5d36de68a1162e9869f08c4703cc1241157738cf17dc92e'
  when '1.0.3' then '7a557242e76612757d0b623afa9dc757c12f51a706216be88d3355195ec0ca97'
  when '1.1.0' then 'd2276df535e0f8e909cd0c1c9700ca275be378145451f9d62a5980b62fdfab74'
  when '1.2.0' then '5dee33dfdf78605caa0bee33caf5cff633613604ec3a30e93dead81c4401f9b9'
  when '1.2.1' then 'eb680d58838b6218cbcb32f4bbf8e9be46adf1df43801e5e83e420ae58bc0d07'
  when '1.3.0' then 'b9674f3235d4937d39186417594efdb3213b564d783aa09618a8086cc57f5170'
  when '1.3.1' then '625af0a8402e85d62768f99a409ce4e140ef3afc961514b549fb9f98877c39db'
  when '1.4.0' then 'c57a5fafb8aaaccea0bd57aae0bce24472ee6d172c0a558c11759b26b6c0196c'
  when '1.5.0' then '6f7180a507a0e4c147e2c6a1fa82daf273e038243acefaa39fa7363472164765'
  when '1.6.0' then '6605a8fbeab3f60567832f2bdba790583646b7ba637eee5b1da8148b5ecacf97'
  when '1.7.0' then '5f2c14e58c98ba90b0de5e6083b6d1892802f2d68b845b594e62d691bf386d0c'
  when '1.8.0' then '0997e056a5befeed5f85b1e4cbe72115d7bd20f2ba30e7b7a105bcc1d3912e76'
  when '1.8.2' then 'ff41c353f73fe90cb0e67860cff7b021833e23df6c49232d1b102a0eae575127'
  when '1.9.0' then '620776f107a9c10f57f59e52be795621f0f0b8277805e28fff7dc664bbb48fb3'
  when '1.9.1' then '3cdad3393611d2c8d151c7d265ebd04764cbaba4a4d745a8b534dd9b8cf77d7b'
  when '2.0.0' then '2d9113ef6e173a65587b373ecc247b58ea8fab5ea826541b1d309ad0402a67be'
  when '2.0.1' then '0568b27367a367aebc45cade27bcca693b034a0b18dfd82789c0a6767324b19d'
  when '2.0.2' then 'c008bfdac59b45d8ce98ec0625e69316b3a5c51ccefa18363322df687d2c78c4'
  when '3.0.0' then '1a4dcea8fa5df919b9c92341b1a3b92aed5892022e0f94733540d1ebb88653df'
  when '3.1.0' then '7d586c65f6f0173c064e5d6508c380192c4a9ac3fc2314fbc3fce2e8f6b10daf'
  when '3.2.0' then 'e306e5d0b1f7bc36124ef2877df608b9c1fa2fb7e88d5252fc7dba680962b882'
  when '3.3.3' then '550a310f3e8cc1ff6efb1bfa1e7730debfc66710c24f97c9ccbeeefd7b845e6c'
  when '3.3.4' then '93071fa04c4519271a50aa34c009144396785d3be685bcab0937e8bef5aa6da0'
  end

default['stash']['backup_diy']['install_path'] = "#{node['stash']['install_path']}/stash-diy-backup"
default['stash']['backup_diy']['repo_url'] = 'https://bitbucket.org/atlassianlabs/atlassian-stash-diy-backup.git'
default['stash']['backup_diy']['revision'] = 'master'

default['stash']['backup_diy']['backup_home_type'] = 'rsync'
default['stash']['backup_diy']['backup_archive_type'] = 'tar'
default['stash']['backup_diy']['exclude_repos'] = []
default['stash']['backup_diy']['gpg_recipient'] = ''
default['stash']['backup_diy']['temp_path'] = '/tmp/stash-backup-temp'
default['stash']['backup_diy']['verbose'] = true

default['stash']['backup_diy']['hipchat_url'] = 'https://api.hipchat.com'
default['stash']['backup_diy']['hipchat_room'] = ''
default['stash']['backup_diy']['hipchat_token'] = ''

default['stash']['database']['type']     = 'postgresql'
# When not set, the defaults from postgresql cookbook are used.
# See: https://github.com/hw-cookbooks/postgresql/blob/v3.4.24/attributes/default.rb#L71-L228
default['stash']['database']['version']  = nil

default['stash']['database']['host'] = '127.0.0.1'
default['stash']['database']['name'] = node['stash']['product']
default['stash']['database']['password'] = 'changeit'
default['stash']['database']['testInterval'] = 2
default['stash']['database']['user'] = node['stash']['product']

# See `libraries/stash.rb` for code to set actual default query_string
default['stash']['database']['query_string'] = ''

# See `libraries/stash.rb` for code to set actual default port
default['stash']['database']['port'] = nil

default['stash']['jvm']['minimum_memory']  = '512m'
default['stash']['jvm']['maximum_memory']  = '768m'
default['stash']['jvm']['maximum_permgen'] = '384m'
default['stash']['jvm']['java_opts']       = ''
default['stash']['jvm']['support_args']    = ''

default['stash']['plugin'] = {}
default['stash']['properties'] = {}

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port']     = '7999'

default['stash']['tomcat']['port'] = '7990'
default['stash']['tomcat']['session-timeout'] = '30'

default['stash']['setup']['admin']['username'] = ''
default['stash']['setup']['admin']['password'] = ''
default['stash']['setup']['admin']['email'] = ''
default['stash']['setup']['admin']['displayname'] = ''

default['stash']['setup']['license'] = ''
default['stash']['setup']['displayname'] = 'Bitbucket'
