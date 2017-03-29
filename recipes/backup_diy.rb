# frozen_string_literal: true

handle_old_stash_attributes!

settings = merge_stash_settings

include_recipe 'yum-epel' if node['platform_family'] == 'rhel'

package 'jq'
package 'perl-Time-Piece' if node['platform_family'] == 'rhel'
package 'rsync'

directory node['stash']['backup_diy']['install_path'] do
  owner node['stash']['user']
  mode 00755
  action :create
  recursive true
end

git 'stash-diy-backup' do
  repository node['stash']['backup_diy']['repo_url']
  revision node['stash']['backup_diy']['revision']
  destination node['stash']['backup_diy']['install_path']
  user node['stash']['user']
end

template "#{node['stash']['backup_diy']['install_path']}/stash.diy-backup.vars.sh" do
  source 'backup-diy-vars.sh.erb'
  owner node['stash']['user']
  mode '0600'
  variables(
    :backup => settings['backup'],
    :backup_diy => settings['backup_diy'],
    :database => settings['database']
  )
end

directory node['stash']['backup']['backup_path'] do
  owner node['stash']['user']
  mode '0750'
  action :create
  recursive true
  not_if { ::Dir.exist?(node['stash']['backup']['backup_path']) }
end

cron_d 'atlassian-stash-diy-backup' do
  hour settings['backup']['cron']['hour']
  minute settings['backup']['cron']['minute']
  day settings['backup']['cron']['day']
  month settings['backup']['cron']['month']
  weekday settings['backup']['cron']['weekday']
  command "#{node['stash']['backup_diy']['install_path']}/stash.diy-backup.sh"
  user node['stash']['user']
  action(settings['backup']['cron']['enable'] ? :create : :delete)
end
