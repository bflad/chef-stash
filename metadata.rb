maintainer        "Brian Flad"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs/Configures Atlassian Stash"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.2.8"
recipe            "stash", "Installs/Configures Atlassian Stash"
recipe            "stash::apache2", "Installs Atlassian Stash behind Apache2"
recipe            "stash::upgrade", "Upgrades Atlassian Stash"

%w{ amazon centos redhat scientific }.each do |os|
  supports os
end

%w{ apache2 database git java mysql postgresql }.each do |cb|
  depends cb
end
