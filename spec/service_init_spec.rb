require 'spec_helper'

describe 'stash::service_init' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
