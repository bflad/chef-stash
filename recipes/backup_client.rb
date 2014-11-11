
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
  mode '0644'
  variables :backup_client => settings['backup_client']
end

link "#{node['stash']['backup_client']['install_path']}/stash-backup-client/backup-config.properties" do
  to "#{node['stash']['home_path']}/backup-config.properties"
end
