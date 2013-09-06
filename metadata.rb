name              "stash"
maintainer        "Brian Flad"
maintainer_email  "bflad417@gmail.com"
license           "Apache 2.0"
description       "Installs/Configures Atlassian Stash"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "2.19.0"
recipe            "stash", "Installs/Configures Atlassian Stash"
recipe            "stash::apache2", "Installs/Configures Atlassian Stash behind Apache2"
recipe            "stash::backup_client", "Installs/Configures Atlassian Stash Backup Client"
recipe            "stash::backup_client_cron", "Installs/Configures Atlassian Stash Backup Client cron.d"
recipe            "stash::upgrade", "Upgrades Atlassian Stash"

%w{ amazon centos redhat scientific ubuntu }.each do |os|
  supports os
end

%w{ apache2 cron database git java mysql mysql_connector perl postgresql ark }.each do |cb|
  depends cb
end
