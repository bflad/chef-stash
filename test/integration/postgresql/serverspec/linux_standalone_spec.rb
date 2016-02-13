require 'spec_helper'

describe user($node['stash']['user']) do
  it { should exist }
  it { should have_home_directory $node['stash']['home_path'] }
end
