require 'spec_helper'

describe 'stash::apache2' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
