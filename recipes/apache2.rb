node.set['apache']['listen_ports'] = node['apache']['listen_ports'] + [node['stash']['apache2']['port']] unless node['apache']['listen_ports'].include?(node['stash']['apache2']['port'])
node.set['apache']['listen_ports'] = node['apache']['listen_ports'] + [node['stash']['apache2']['ssl']['port']] unless node['apache']['listen_ports'].include?(node['stash']['apache2']['ssl']['port'])

include_recipe 'apache2'
include_recipe 'apache2::mod_proxy'
include_recipe 'apache2::mod_proxy_http'
include_recipe 'apache2::mod_ssl'

# Disable mod_auth_basic because it isn't supported in Stash 2.10 and later
apache_module 'auth_basic' do
  enable false
end

web_app node['stash']['apache2']['virtual_host_name']
