# frozen_string_literal: true
require 'spec_helper'

describe 'stash::default' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['stash']['install_path'] = '/opt/atlassian'
      node.set['stash']['home_path'] = '/var/atlassian/application-data/bitbucket'
      node.set['postgresql']['password']['postgres'] = 'postgres_pass'
    end.converge(described_recipe)
  end

  before do
    # Required for 'apache2::default' converge
    stub_command('/usr/sbin/apache2 -t').and_return(true)

    # Required for 'postgresql::server' converge
    stub_command(%r{ls \/.*\/recovery.conf}).and_return(false)
  end

  it 'renders server.xml' do
    path = '/var/atlassian/application-data/bitbucket/shared/server.xml'
    resource = chef_run.template(path)

    expect(resource).to notify('service[bitbucket]').to(:restart)
    expect(chef_run).to render_file(path)
  end

  it 'renders web.xml' do
    path = '/opt/atlassian/bitbucket/conf/web.xml'
    resource = chef_run.template(path)

    expect(resource).to notify('service[bitbucket]').to(:restart)
    expect(chef_run).to render_file(path)
  end

  it 'renders setenv.sh' do
    expect(chef_run).to render_file('/opt/atlassian/bitbucket/bin/setenv.sh')
      .with_content { |content|
        expect(content).to include('export BITBUCKET_HOME="/var/atlassian/application-data/bitbucket"')
      }
  end
end
