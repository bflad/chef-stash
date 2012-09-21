# chef-stash  [![Build Status](https://secure.travis-ci.org/bflad/chef-stash.png?branch=master)](http://travis-ci.org/bflad/chef-stash)

## Description

Installs/Configures Atlassian Stash.

## Requirements

### Platforms

* RedHat 6.3

### Cookbooks

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* apache2 (if using Apache 2 proxy)
* database
* git
* java
* mysql
* postgresql

## Attributes

* `node['stash']['version']` - Stash version to install (use
  `recipe[stash::upgrade]` to upgrade to version defined)
* `node['stash']['url']` - URL for Stash installer .tar.gz
* `node['stash']['checksum']` - SHA256 checksum for Stash installer .tar.gz
* `node['stash']['backup_home']` - backup home directory during upgrade,
  defaults to true
* `node['stash']['backup_install']` - backup install directory during upgrade,
  defaults to true
* `node['stash']['install_backup']` - location of install directory backup
  during upgrade
* `node['stash']['install_path']` - location to install Stash, defaults to
  `/opt/atlassian-stash`
* `node['stash']['run_user']` - user to run Stash, defaults to "stash"
* `node['stash']['home_backup']` - location of home directory backup during
  upgrade
* `node['stash']['home_path']` - home directory for Stash run_user, defaults to
  `/home/#{node['stash']['run_user']}`

### Stash JVM Attributes

* `node['stash']['jvm']['minimum_memory']` - defaults to "256m"
* `node['stash']['jvm']['maximum_memory']` - defaults to "768m"
* `node['stash']['jvm']['maximum_permgen']` - defaults to "256m"
* `node['stash']['jvm']['java_opts']` - additional JAVA_OPTS to be passed to
  Stash JVM during startup
* `node['stash']['jvm']['support_args']` - additional JAVA_OPTS recommended by
  Atlassian support for Stash JVM during startup

### Stash MySQL Attributes

* `node['stash']['mysql']['connector']['version']` - MySQL Connector/J version
  (if required)
* `node['stash']['mysql']['connector']['url']` - URL for MySQL Connector/J
* `node['stash']['mysql']['connector']['checksum']` - SHA256 checksum of MySQL
  Connector/J

### Stash Tomcat Attributes

* `node['stash']['tomcat']['port']` - port to run Tomcat HTTP, defaults to
  7990
* `node['stash']['tomcat']['ssl_port']` - port to run Tomcat HTTPS, defaults
  to 8443

## Recipes

* `recipe[stash]` Installs Atlassian Stash with built-in Tomcat
* `recipe[stash::apache2]` Installs above with Apache 2 proxy (ports 80/443)
* `recipe[stash::upgrade]` Upgrades Atlassian Stash

## Usage

### Required Stash Data Bag

Create a stash/stash encrypted data bag with the following information per
Chef environment:

_required:_
* `['database']['type']` - mysql/postgresql
* `['database']['host']` - FQDN/localhost
* `['database']['name']` - Name of database
* `['database']['user']` - Credentials username
* `['database']['password']` - Credentials password
_optional:_
* `['configuration']['license']` - _NOT OPERATIONAL_ - Stash License
* `['database']['port']` - Database port
* `['tomcat']['keyAlias']` - Tomcat HTTPS Java Keystore keyAlias
* `['tomcat']['keystoreFile']` - Tomcat HTTPS Java Keystore keystoreFile
* `['tomcat']['keystorePass']` - Tomcat HTTPS Java Keystore keystorePass

Repeat for other Chef environments as necessary. Example:

    {
      "id": "stash"
      "development": {
        "configuration": {
          "license": "STASH-LICENSE-KEY"
        },
        "database": {
          "type": "postgresql",
          "host": "localhost",
          "name": "stash",
          "user": "stash",
          "password": "stash_db_password",
        },
        "tomcat": {
          "keyAlias": "not_tomcat",
          "keystoreFile": "/etc/pki/java/wildcard_cert.jks",
          "keystorePass": "not_changeit"
        }
      }
    }

### Stash Installation

* Create required encrypted data bag
* Add `recipe[stash]` to your run_list.

_PLEASE NOTE:_ Due to how Stash handles the setup process, you might
still be asked for database information when initially setting up the
server. I submitted [STASH-2687](https://jira.atlassian.com/browse/STASH-2687)
to fix this.

### Stash with Apache2 Frontend

* Create required encrypted data bag
* Add `recipe[stash::apache2]` to your run_list.

### Stash Upgrades

* Update `node['stash']['version']` and `node['stash']['checksum']` attributes
* Add `recipe[stash::upgrade]` to your run_list, such as:
  `knife node run_list add NODE_NAME "recipe[stash::upgrade]"`
  It will automatically remove itself from the run_list after completion.

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.