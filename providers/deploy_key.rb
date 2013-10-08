action :create do
  key_path = "#{node['stash']['install_path']}/#{new_resource.alias}_ssh_key.pem"
  wrapper_path = "#{node['stash']['install_path']}/#{new_resource.alias}_ssh_wrapper.sh"

  directory node['stash']['install_path'] do
    owner 'root'
    group 'root'
    mode 0755
    action :create
    not_if { ::File.exists?(node['stash']['install_path']) }
  end

  file key_path do
    owner new_resource.owner
    mode 0400
    content new_resource.key
    action :create
  end

  template wrapper_path do
    source 'ssh_wrapper.sh.erb'
    cookbook 'stash'
    owner new_resource.owner
    mode 0500
    variables(:key_path => key_path)
  end

  new_resource.updated_by_last_action(true)
end
