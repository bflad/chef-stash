# frozen_string_literal: true
template "/etc/init.d/#{node['stash']['product']}" do
  if node['stash']['product'] == 'stash'
    source 'stash.init.erb'
  else
    source 'bitbucket/bitbucket.init.erb'
  end
  mode '0755'
  notifies :restart, "service[#{node['stash']['product']}]", :delayed
end

# disable stash service after upgrade to bitbucket 4.0
if node['stash']['product'] == 'bitbucket'
  service 'stash' do
    supports :status => true, :restart => true
    action [:stop, :disable]
  end

  file '/etc/init.d/stash' do
    action :delete
  end
end

service node['stash']['product'] do
  supports :status => true, :restart => true
  action [:enable]
  subscribes :restart, 'java_ark[jdk]'
end
