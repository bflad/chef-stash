name              'stash'
maintainer        'Brian Flad'
maintainer_email  'bflad417@gmail.com'
license           'Apache 2.0'
description       'Installs/Configures Atlassian Stash'
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           '3.1.1'
recipe            'stash', 'Installs/Configures Atlassian Stash'
recipe            'stash::apache2', 'Installs/Configures Apache 2 proxy for Stash'
recipe            'stash::backup_client', 'Installs/Configures Atlassian Stash Backup Client'
recipe            'stash::backup_client_cron', 'Installs/Configures Atlassian Stash Backup Client cron.d'
recipe            'stash::configuration', "Configures Stash's settings"
recipe            'stash::database', 'Installs/configures MySQL/Postgres server, database, and user for Stash'
recipe            'stash::linux_standalone', 'Installs/configures Stash via Linux standalone archive'
recipe            'stash::service_init', 'Installs/configures Stash init service'
recipe            'stash::tomcat_configuration', "Configures Stash's built-in Tomcat"

%w{ amazon centos redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ apache2 ark cron database git java mysql mysql_connector perl postgresql }.each do |cb|
  depends cb
end
