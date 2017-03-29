# frozen_string_literal: true

platform = 'windows' if node['platform_family'] == 'windows'
platform ||= 'linux'
settings = merge_stash_settings

if node['platform_family'] == 'rhel' && node['platform_version'].to_f < 7
  include_recipe 'git::source'
else
  include_recipe 'git'
end
include_recipe 'perl'

include_recipe 'stash::database' if settings['database']['host'] == '127.0.0.1'
include_recipe "stash::#{platform}_#{node['stash']['install_type']}"
include_recipe 'stash::configuration'
include_recipe 'stash::tomcat_configuration'
include_recipe 'stash::apache2'
include_recipe "stash::service_#{node['stash']['service_type']}"

case node['stash']['backup']['strategy']
when 'backup_client'
  include_recipe 'stash::backup_client'
when 'backup_diy'
  include_recipe 'stash::backup_diy'
end
