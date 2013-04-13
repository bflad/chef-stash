require File.expand_path('../support/helpers', __FILE__)

describe_recipe "stash::default" do
  include Helpers::Stash

  it 'has stash run_user' do
  	user(node['stash']['run_user']).must_exist.with(:home, node['stash']['home_path'])
  end

  it 'creates Java KeyStore' do
  	file("#{node['stash']['home_path']}/.keystore").must_exist.with(:owner, node['stash']['run_user'])
  end

  it 'creates Stash properties file' do
  	file("#{node['stash']['home_path']}/stash-config.properties").must_exist
  end

  it 'starts Stash' do
    service("stash").must_be_running
  end

  it 'enables Stash' do
    service("stash").must_be_enabled
  end
  
end
