maintainer        "Brian Flad"
maintainer_email  "bflad@wharton.upenn.edu"
license           "Apache 2.0"
description       "Installs Atlassian Stash"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "stash", "Installs Atlassian Stash"
recipe            "stash::apache2", "Installs Atlassian Stash behind Apache2"

%w{ amazon centos redhat scientific }.each do |os|
  supports os
end

%w{ database git java mysql postgresql }.each do |cb|
  depends cb
end

%w{ apache2 }.each do |cb|
  suggests cb
end
