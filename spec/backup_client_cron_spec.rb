require 'spec_helper'

describe 'stash::backup_client_cron' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
