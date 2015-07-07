require 'serverspec'
require 'json'

set :backend, :exec

$node = ::JSON.parse(File.read('/tmp/test-helper/node.json'))

shared_examples_for 'stash' do
end

shared_examples_for 'database' do
  possible_bins = ['psql', 'mysql']

  case $node['stash']['database']['type']
  when 'mysql'
    installed_bin = possible_bins.delete 'mysql'
  when 'postgresql'
    installed_bin = possible_bins.delete 'psql'
  end

  # Correct DB should be available
  describe command("command -v #{installed_bin}") do
    its(:exit_status) { should eq 0 }
  end

  # Other DBs should not be available
  possible_bins.each do |uninstalled_bin|
    describe command("command -v #{uninstalled_bin}") do
      its(:exit_status) { should_not eq 0 }
    end
  end
end
