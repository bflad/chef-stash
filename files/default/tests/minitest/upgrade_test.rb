require File.expand_path('../support/helpers', __FILE__)

describe_recipe "stash::upgrade" do
  include Helpers::Stash

  it 'backs up Stash home directory' do
  	skip unless node['stash']['backup_home']
  	file("#{node['stash']['home_backup']}").must_exist
  end

  it 'backs up Stash install directory' do
  	skip unless node['stash']['backup_install']
  	file("#{node['stash']['install_backup']}").must_exist
  end

  it 'starts Stash' do
    service("stash").must_be_running
  end

  it 'enables Stash' do
    service("stash").must_be_enabled
  end

end
