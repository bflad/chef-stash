# frozen_string_literal: true

settings = merge_stash_settings

directory File.dirname(node['stash']['home_path']) do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end

user node['stash']['user'] do
  comment 'Stash Service Account'
  home node['stash']['home_path']
  shell '/bin/bash'
  manage_home true
  system true
  action :create
end

directory node['stash']['install_path'] do
  owner 'root'
  group 'root'
  mode 00755
  action :create
  recursive true
end

# needed only for upgrading from 4.x.x to 5.x.x
# if removed, the old bitbucket instance won't be terminated via service[#{node['stash]['product']}]
if Chef::Version.new(node['stash']['version']) >= Chef::Version.new('5.0.0') && Dir.glob("#{node['stash']['install_path']}/#{node['stash']['product']}-5.*").empty?
  service node['stash']['product'] do
    action :stop
  end
end

ark node['stash']['product'] do
  url stash_artifact_url
  prefix_root node['stash']['install_path']
  prefix_home node['stash']['install_path']
  checksum stash_artifact_checksum
  version node['stash']['version']
  owner node['stash']['user']
  group node['stash']['user']
end

if settings['database']['type'] == 'mysql'
  directory "#{node['stash']['home_path']}/lib" do
    owner node['stash']['user']
    group node['stash']['user']
    mode 00755
    action :create
  end

  mysql_connector_j "#{node['stash']['home_path']}/lib"
end
