# frozen_string_literal: true

settings = merge_stash_settings

database_connection = {
  :host         => settings['database']['host'],
  :port         => settings['database']['port'],
  :query_string => settings['database']['query_string']
}

case settings['database']['type']
when 'mysql'

  mysql2_chef_gem 'default' do
    client_version settings['database']['version'] if settings['database']['version']
    action :install
  end

  mysql_service 'default' do
    version settings['database']['version'] if settings['database']['version']
    bind_address settings['database']['host']
    # See: https://github.com/chef-cookbooks/mysql/pull/361
    port settings['database']['port'].to_s
    data_dir node['mysql']['data_dir'] if node['mysql']['data_dir']
    initial_root_password node['mysql']['server_root_password']
    action %i[create start]
  end

  database_connection[:username] = 'root'
  database_connection[:password] = node['mysql']['server_root_password']

  mysql_database settings['database']['name'] do
    connection database_connection
    collation 'utf8_bin'
    encoding 'utf8'
    action :create
  end

  # See this MySQL bug: http://bugs.mysql.com/bug.php?id=31061
  mysql_database_user '' do
    connection database_connection
    host '127.0.0.1'
    action :drop
  end

  mysql_database_user settings['database']['user'] do
    connection database_connection
    host '%'
    password settings['database']['password']
    database_name settings['database']['name']
    action %i[create grant]
  end
when 'postgresql'
  include_recipe 'postgresql::server'
  include_recipe 'database::postgresql'
  database_connection[:username] = 'postgres'
  database_connection[:password] = node['postgresql']['password']['postgres']

  postgresql_database settings['database']['name'] do
    connection database_connection
    connection_limit '-1'
    encoding 'utf8'
    action :create
  end

  postgresql_database_user settings['database']['user'] do
    connection database_connection
    password settings['database']['password']
    database_name settings['database']['name']
    action %i[create grant]
  end
end
