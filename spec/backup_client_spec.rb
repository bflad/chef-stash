require 'spec_helper'

describe 'stash::backup_client' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
