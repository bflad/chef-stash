template '/etc/init.d/stash' do
  source 'stash.init.erb'
  mode   '0755'
  notifies :restart, 'service[stash]', :delayed
end

service 'stash' do
  supports :status => true, :restart => true
  action [:enable, :start]
  subscribes :restart, 'java_ark[jdk]'
end
