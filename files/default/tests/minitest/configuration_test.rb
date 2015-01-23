require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'stash::configuration' do
  include Helpers::Stash

  it 'creates Stash properties file' do
    file("#{node['stash']['home_path']}/shared/stash-config.properties").must_exist
  end
end
