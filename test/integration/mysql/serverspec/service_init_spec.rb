require 'spec_helper'

# Default tests are in spec_helper.
describe 'mysql' do
  it_behaves_like 'stash'
end

# Insert suite-specific tests below this line.
describe service('stash') do
  it { should be_enabled }
  it { should be_running }
end

describe port($node['stash']['tomcat']['port']) do
  it { should be_listening }
end

describe port($node['stash']['tomcat']['ssl_port']) do
  it { should be_listening }
end
