# frozen_string_literal: true
require 'spec_helper'

describe 'stash::tomcat_configuration' do
  let(:chef_run) do
    ChefSpec::Runner.new.converge(described_recipe)
  end
end
