Stash.check_for_old_attributes!(node)

settings = Stash.settings(node)

package 'unzip'
package 'rsync'

ark 'stash-backup-client' do
  url node['stash']['backup_client']['url']
  prefix_root node['stash']['backup_client']['install_path']
  prefix_home node['stash']['backup_client']['install_path']
  checksum node['stash']['backup_client']['checksum']
  version node['stash']['backup_client']['version']
  owner node['stash']['user']
  group node['stash']['user']
end

template "#{node['stash']['home_path']}/backup-config.properties" do
  source 'backup-config.properties.erb'
  owner node['stash']['user']
  mode '0600'
  variables :backup => settings['backup']
end

link "#{node['stash']['backup_client']['install_path']}/stash-backup-client/backup-config.properties" do
  to "#{node['stash']['home_path']}/backup-config.properties"
end

directory node['stash']['backup']['backup_path'] do
  owner node['stash']['user']
  mode '0750'
  action :create
  not_if { ::Dir.exist?(node['stash']['backup']['backup_path']) }
end

cron_d 'atlassian-stash-backup-client' do
  hour settings['backup']['cron']['hour']
  minute settings['backup']['cron']['minute']
  day settings['backup']['cron']['day']
  month settings['backup']['cron']['month']
  weekday settings['backup']['cron']['weekday']
  command "java -jar #{node['stash']['backup_client']['install_path']}/stash-backup-client/stash-backup-client.jar"
  user node['stash']['user']
  action(settings['backup']['cron']['enable'] ? :create : :delete)
end
