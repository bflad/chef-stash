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

if ($node['stash']['ipversion']) == 4
  describe port($node['stash']['tomcat']['port']) do
    its('protocols') { should include 'tcp' }
  end
else
  describe port($node['stash']['tomcat']['port']) do
    its('protocols') { should include 'tcp6'}
  end
end

describe port($node['stash']['apache2']['port']) do
  it { should be_listening }
end

describe port($node['stash']['apache2']['ssl']['port']) do
  it { should be_listening }
end



if ($node['platform'].downcase) == 'ubuntu' && ($node['platform_version'].to_f) >= 15.04
  describe file("/etc/systemd/system/#{$node['stash']['product']}.service") do
    it { should be_file }
  end
else
  describe file("/etc/init.d/#{$node['stash']['product']}") do
    it { should be_file }
  end
end