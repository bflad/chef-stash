
settings = Stash.settings(node)

include_recipe "ark"
package "unzip"

ark node['stash']['backup_client']['name'] do
  url node['stash']['backup_client']['url']
  home_dir node['stash']['backup_client']['install_path']
  checksum node['stash']['backup_client']['checksum']
  version node['stash']['backup_client']['version']
  owner node['stash']['run_user']
  group node['stash']['run_user']
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
