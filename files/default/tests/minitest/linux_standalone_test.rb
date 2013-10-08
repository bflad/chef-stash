require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'stash::linux_standalone' do
  include Helpers::Stash

  it 'has stash user' do
    user(node['stash']['user']).must_exist.with(:home, node['stash']['home_path'])
  end

  it 'creates Java KeyStore' do
    file("#{node['stash']['home_path']}/.keystore").must_exist.with(:owner, node['stash']['user'])
  end

end
