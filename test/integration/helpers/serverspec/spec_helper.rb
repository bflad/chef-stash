require 'serverspec'
require 'json'

set :backend, :exec

$node = ::JSON.parse(File.read('/tmp/test-helper/node.json'))

shared_examples_for 'stash' do
end
