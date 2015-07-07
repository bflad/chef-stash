require 'spec_helper'

# Default tests are in spec_helper.
describe 'postgresql' do
  it_behaves_like 'stash'
end

# Insert suite-specific tests below this line.
describe file("#{$node['stash']['home_path']}/shared/stash-config.properties") do
  it { should be_file }
  it { should exist }
end

describe file("#{$node['apache']['dir']}/sites-available/#{$node['stash']['apache2']['virtual_host_name']}.conf") do
  it { should be_file }
  it { should exist }
end

describe service($node['apache']['service_name']) do
  it { should be_enabled }
  it { should be_running }
end

describe port($node['stash']['apache2']['port']) do
  it { should be_listening }
end

describe port($node['stash']['apache2']['ssl']['port']) do
  it { should be_listening }
end
