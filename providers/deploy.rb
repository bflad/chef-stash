action :deploy do
  g = git new_resource.destination do
    repository "ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}/#{new_resource.project}/#{new_resource.repository}.git"
    revision new_resource.revision
    user new_resource.user
    group new_resource.group
    action new_resource.deploy_action
    ssh_wrapper "#{node['stash']['install_path']}/#{new_resource.deploy_key}_ssh_wrapper.sh"
  end

  new_resource.updated_by_last_action(g.updated?)
end
