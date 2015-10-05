require 'spec_helper'

# Default tests are in spec_helper.
describe 'mysql' do
  it_behaves_like 'stash'
end

# Insert suite-specific tests below this line.
describe file("#{$node['stash']['home_path']}/shared/bitbucket.properties") do
  it { should be_file }
  it { should exist }
end
