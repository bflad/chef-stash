require 'spec_helper'

describe 'stash::database' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
