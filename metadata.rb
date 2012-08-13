maintainer        "Brian Flad"
maintainer_email  "bflad417@gmail.com"
license           "Apache 2.0"
description       "Installs Atlassian Stash"
long_description  IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version           "0.0.1"
recipe            "stash", "Installs Atlassian Stash"

%w{ amazon centos redhat scientific }.each do |os|
  supports os
end

%w{ database git java postgresql }.each do |cb|
  depends cb
end
