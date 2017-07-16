# frozen_string_literal: true

if (node['platform'] == 'ubuntu' && node['platform_version'].to_f >= 15.04) || (node['platform'] == 'centos' && node['platform_version'].to_f >= 7.0)
  template "/etc/systemd/system/#{node['stash']['product']}.service" do
    source 'bitbucket/bitbucket.service.systemd.erb'
  end
else
  template "/etc/init.d/#{node['stash']['product']}" do
    if node['stash']['product'] == 'stash'
      source 'stash.init.erb'
    else
      source 'bitbucket/bitbucket.init.erb'
    end
    mode '0755'
    notifies :restart, "service[#{node['stash']['product']}]", :delayed
  end
end

# disable stash service after upgrade to bitbucket 4.0
if node['stash']['product'] == 'bitbucket'
  service 'stash' do
    supports :status => true, :restart => true
    action %i[stop disable]
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
