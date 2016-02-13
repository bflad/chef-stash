require 'spec_helper'

# Default tests are in spec_helper.
describe 'postgresql' do
  it_behaves_like 'stash'
end

# Insert suite-specific tests below this line.
describe service('bitbucket') do
  it { should be_enabled }
  it { should be_running }
end

describe port($node['stash']['tomcat']['port']) do
  it { should be_listening }
end
