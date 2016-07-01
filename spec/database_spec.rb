# frozen_string_literal: true
require 'spec_helper'

describe 'stash::database' do
  let(:chef_run) do
    ChefSpec::SoloRunner.new do |node|
      node.set['stash']['data_bag_name'] = 'apps'
      node.set['stash']['data_bag_item'] = 'test_stash'
      node.set['stash']['database']['name'] = 'test_database'
      node.set['stash']['database']['user'] = 'foo'
      node.set['stash']['database']['password'] = 'bar'
      node.set['mysql']['server_root_password'] = 'mysql_root_pass'
      node.set['postgresql']['password']['postgres'] = 'postgres_pass'
    end.converge(described_recipe)
  end

  before do
    # Required for "postgresql::server" converge
    stub_command(%r{ls \/.*\/recovery.conf}).and_return(false)
  end

  it 'raises an error unsupported database type is specified' do
    chef_run.node.set['stash']['database']['type'] = 'unicorn'
    expect { chef_run.converge(described_recipe) }.to raise_error
  end

  context 'When data bag does not exit' do
    let(:connection) do
      {
        host: '127.0.0.1',
        port: 5432,
        username: 'postgres',
        password: 'postgres_pass'
      }
    end

    it 'sets up PostgreSQL service' do
      expect(chef_run).to include_recipe('postgresql::server')
      expect(chef_run).to include_recipe('database::postgresql')
    end

    it 'creates PostgreSQL user' do
      expect(chef_run).to create_postgresql_database_user('foo').with(
        password: 'bar',
        connection: connection
      )
    end

    it 'creates PostgeSQL database' do
      expect(chef_run).to create_postgresql_database('test_database').with(
        encoding: 'utf8',
        connection: connection
      )
    end
  end

  context 'When data bag exists' do
    before do
      data_bag = {
        'id' => 'test_stash',
        'stash' => {
          'database' => {
            'type' => 'mysql',
            'user' => 'db_user',
            'password' => 'db_password'
          }
        }
      }
      stub_data_bag('apps').and_return(['test_stash'])
      stub_data_bag_item('apps', 'test_stash').and_return(data_bag)
    end

    let(:connection) do
      {
        host: '127.0.0.1',
        port: 3306,
        username: 'root',
        password: 'mysql_root_pass'
      }
    end

    it 'sets up MySQL service' do
      expect(chef_run).to create_mysql_service('default').with(
        bind_address: '127.0.0.1',
        port: '3306',
        initial_root_password: 'mysql_root_pass'
      )
    end

    it 'creates MySQL database' do
      expect(chef_run).to create_mysql_database('test_database').with(
        collation: 'utf8_bin',
        encoding: 'utf8',
        connection: connection
      )
    end

    it 'creates MySQL user' do
      expect(chef_run).to create_mysql_database_user('db_user').with(
        host: '%',
        password: 'db_password',
        database_name: 'test_database',
        connection: connection
      )
    end
  end
end
