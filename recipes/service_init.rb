template "/etc/init.d/#{node['stash']['product']}" do
  if node['stash']['product'] == 'stash'
    source 'stash.init.erb'
  else
    source 'bitbucket/bitbucket.init.erb'
  end
  mode '0755'
  notifies :restart, "service[#{node['stash']['product']}]", :delayed
end

service node['stash']['product'] do
  supports :status => true, :restart => true
  action [:enable]
  subscribes :restart, 'java_ark[jdk]'
end
