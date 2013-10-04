
settings = Stash.settings(node)

package "unzip"

remote_file "#{Chef::Config[:file_cache_path]}/stash-backup-client-#{node['stash']['backup_client']['version']}.zip" do
  source    node['stash']['backup_client']['url']
  checksum  node['stash']['backup_client']['checksum']
  mode      "0644"
  action    :create_if_missing
end

execute "Extracting Stash Backup Client #{node['stash']['backup_client']['version']}" do
  cwd Chef::Config[:file_cache_path]
  command <<-COMMAND
    unzip stash-backup-client-#{node['stash']['backup_client']['version']}.zip
    mv stash-backup-client-#{node['stash']['backup_client']['version']} #{node['stash']['backup_client']['install_path']}
    chown -R #{node['stash']['run_user']} #{node['stash']['backup_client']['install_path']}
  COMMAND
  creates "#{node['stash']['backup_client']['install_path']}/stash-backup-client.jar"
end

template "#{node['stash']['home_path']}/backup-config.properties" do
  source "backup-config.properties.erb"
  owner  node['stash']['run_user']
  mode   "0644"
  variables :backup_client => settings['backup_client']
end

link "#{node['stash']['backup_client']['install_path']}/backup-config.properties" do
  to "#{node['stash']['home_path']}/backup-config.properties"
end
