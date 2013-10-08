settings = Stash.settings(node)

template "#{node['stash']['home_path']}/stash-config.properties" do
  source 'stash-config.properties.erb'
  owner  node['stash']['user']
  mode   '0644'
  variables(
      :database => settings['database'],
      :plugin   => settings['plugin']
  )
  notifies :restart, 'service[stash]', :delayed
end
