settings = Stash.settings(node)
stash_version = Chef::Version.new(node['stash']['version'])

# Config path changed to shared/ from 3.2.0
# https://confluence.atlassian.com/display/STASHKB/Upgrading+your+Stash+home+directory+for+Stash+3.2+manually
if stash_version >= Chef::Version.new('3.2.0')
  config_path = 'shared/'
  directory("#{node['stash']['home_path']}/#{config_path}") do
    owner node['stash']['user']
    group node['stash']['user']
    mode '0755'
    action :create
    recursive true
  end
else
  config_path = '/'
end

template "#{node['stash']['home_path']}/#{config_path}stash-config.properties" do
  source 'stash-config.properties.erb'
  owner node['stash']['user']
  mode '0644'
  variables(
      :database   => settings['database'],
      # DEPRECATED: use properties instead
      :plugin     => settings['plugin'],
      :properties => settings['properties']
  )
  notifies :restart, 'service[stash]', :delayed
end
