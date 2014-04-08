require 'spec_helper'

describe 'stash::linux_standalone' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
