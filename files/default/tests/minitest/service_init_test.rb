require File.expand_path('../support/helpers', __FILE__)

describe_recipe 'stash::service_init' do
  include Helpers::Stash

  it 'starts Stash' do
    service('stash').must_be_running
  end

  it 'enables Stash' do
    service('stash').must_be_enabled
  end

end
