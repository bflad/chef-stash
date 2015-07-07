require 'spec_helper'

describe user('stash') do
  it { should exist }
  it { should have_home_directory $node['stash']['home_path'] }
end

# Java keystore
describe file("#{$node['stash']['home_path']}/.keystore") do
  it { should exist }
  it { should be_file }
  it { should be_owned_by $node['stash']['user'] }
end
