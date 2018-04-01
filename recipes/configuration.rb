# frozen_string_literal: true

settings = merge_stash_settings
stash_version = Chef::Version.new(node['stash']['version'])

# Config path changed to shared/ from 3.2.0
# https://confluence.atlassian.com/display/STASHKB/Upgrading+your+Stash+home+directory+for+Stash+3.2+manually
if stash_version >= Chef::Version.new('3.2.0')
  if node['stash']['product'] == 'stash'
    config_path = 'shared/stash-config.properties'
  else
    config_path = 'shared/bitbucket.properties'

    # delete old config file from stash, when both configs exist, bitbucket will not start
    file "#{node['stash']['home_path']}/shared/stash-config.properties" do
      action :delete
    end
  end

  directory("#{node['stash']['home_path']}/shared") do
    owner node['stash']['user']
    group node['stash']['user']
    mode '0755'
    action :create
    recursive true
  end

  bash 'update home path permission' do
    code <<-SHELL
      chown -R #{node['stash']['user']}:#{node['stash']['user']} #{node['stash']['home_path']}
    SHELL
  end
else
  config_path = '/stash-config.properties'
end

if stash_version >= Chef::Version.new('5.0.0')
  template "#{node['stash']['install_path']}/bitbucket/bin/set-jre-home.sh" do
    source 'bitbucket5/set-jre-home.sh.erb'
    owner node['stash']['user']
    mode '0755'
  end
end

template "#{node['stash']['home_path']}/#{config_path}" do
  source 'stash-config.properties.erb'
  owner node['stash']['user']
  mode '0644'
  variables(
    :database   => settings['database'],
    # DEPRECATED: use properties instead
    :plugin     => settings['plugin'],
    :properties => settings['properties']
  )
  notifies :restart, "service[#{node['stash']['product']}]", :delayed
end
