# chef-stash  [![Build Status](https://secure.travis-ci.org/bflad/chef-stash.png?branch=master)](http://travis-ci.org/bflad/chef-stash)

## Description

Installs/Configures Atlassian Stash server. Provides LWRPs for code deployment via Stash. Please see COMPATIBILITY.md for more information about Stash releases (versions and checksums) that are tested and supported by cookbook versions.

## Requirements

### Platforms

* RedHat 6.3

### Databases

* MySQL
* Postgres

### Cookbooks

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* apache2 (if using Apache 2 proxy)
* database
* git
* java
* mysql (if using MySQL database)
* postgresql (if using Postgres database)

Third-Party Cookbooks

* [mysql_connector](https://github.com/bflad/chef-mysql_connector) (if using MySQL database)

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

### Stash Database Attributes

All of these attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

* `node['stash']['database']['host']` - FQDN or "localhost" (localhost automatically installs `['database']['type']` server), defaults to "localhost"
* `node['stash']['database']['name']` - defaults to "stash"
* `node['stash']['database']['password']` - defaults to "changeit"
* `node['stash']['database']['port']` - defaults to 3306
* `node['stash']['database']['type']` - "mysql" or "postgresql", defaults to "mysql"
* `node['stash']['database']['user']` - defaults to "stash"

### Stash JVM Attributes

* `node['stash']['jvm']['minimum_memory']` - defaults to "256m"
* `node['stash']['jvm']['maximum_memory']` - defaults to "768m"
* `node['stash']['jvm']['maximum_permgen']` - defaults to "256m"
* `node['stash']['jvm']['java_opts']` - additional JAVA_OPTS to be passed to
  Stash JVM during startup
* `node['stash']['jvm']['support_args']` - additional JAVA_OPTS recommended by
  Atlassian support for Stash JVM during startup

### Stash SSH Attributes ###

* `node['stash']['ssh']['hostname']` - Stash SSH hostname, defaults to `node['fqdn']`
* `node['stash']['ssh']['port']` - Stash SSH port, defaults to 7999
* `node['stash']['ssh']['uri']` - Stash SSH URI, defaults to `"ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}"`

### Stash Tomcat Attributes

Any `node['stash']['tomcat']['key*']` attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

* `node['stash']['tomcat']['keyAlias']` - defaults to "tomcat"
* `node['stash']['tomcat']['keystoreFile']` - will automatically generate self-signed keystore file if left as default, defaults to `#{node['stash']['home_path']}/.keystore`
* `node['stash']['tomcat']['keystorePass'] - defaults to "changeit"
* `node['stash']['tomcat']['port']` - port to run Tomcat HTTP, defaults to
  7990
* `node['stash']['tomcat']['ssl_port']` - port to run Tomcat HTTPS, defaults
  to 8443

## Recipes

* `recipe[stash]` Installs Atlassian Stash with built-in Tomcat
* `recipe[stash::apache2]` Installs above with Apache 2 proxy (ports 80/443)
* `recipe[stash::upgrade]` Upgrades Atlassian Stash

## LWRPs

* `stash_deploy` - wrapper Git resource for using a `stash_deploy_key`, project, and repository for code deployment
* `stash_deploy_key` - creates SSH private key file and SSH wrapper for code deployment

## Usage

### Stash Server Data Bag

For securely overriding attributes on Hosted Chef, create a `stash/stash` encrypted data bag with the model below. Chef Solo can override the same attributes with a `stash/stash` unencrypted data bag of the same information.

_required:_
* `['database']['type']` - "mysql" or "postgresql"
* `['database']['host']` - FQDN or "localhost" (localhost automatically
  installs `['database']['type']` server)
* `['database']['name']` - Name of Stash database
* `['database']['user']` - Stash database username
* `['database']['password']` - Stash database username password

_optional:_
* `['database']['port']` - Database port, defaults to standard database port for
  `['database']['type']`
* `['tomcat']['keyAlias']` - Tomcat HTTPS Java Keystore keyAlias, defaults to
  self-signed certifcate
* `['tomcat']['keystoreFile']` - Tomcat HTTPS Java Keystore keystoreFile,
  defaults to self-signed certificate
* `['tomcat']['keystorePass']` - Tomcat HTTPS Java Keystore keystorePass,
  defaults to self-signed certificate

Repeat for other Chef environments as necessary. Example:

    {
      "id": "stash"
      "development": {
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

### Stash Server Installation

* Optionally (un)encrypted data bag or set attributes
  * `knife data bag create stash`
  * `knife data bag edit stash stash --secret-file=path/to/secret`
* Add `recipe[stash]` to your node's run list.

### Stash Server Installation with Apache 2 Frontend

* Optionally (un)encrypted data bag or set attributes
  * `knife data bag create stash`
  * `knife data bag edit stash stash --secret-file=path/to/secret`
* Add `recipe[stash::apache2]` to your node's run list.

### Stash Server Upgrades

* Update `node['stash']['version']` and `node['stash']['checksum']` attributes
* Add `recipe[stash::upgrade]` to your run_list, such as:
  `knife node run_list add NODE_NAME "recipe[stash::upgrade]"`
  It will automatically remove itself from the run_list after completion.

### Code Deployment From Stash

* Ensure your node has Git installed
* Create a `stash_deploy_key` with the SSH private key contents (using `\n` for newlines) of a Stash user with permissions to your repository. For example:

    stash_deploy_key "deployment_user" do
      key "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIB..."
    end

* In this example, now you can either directly use the ssh_wrapper available at `#{node['stash']['install_path']}/deployment_user_ssh_wrapper.sh` or use the `stash_deploy` LWRP such as:

    stash_deploy "/opt/shibboleth-idp/conf" do
      deploy_key "deployment_user"
      project "SHIBIDP"
      repository "configuration"
    end

## Contributing

Please use standard Github issues/pull requests.

## License and Author
      
Author:: Brian Flad (<bflad@wharton.upenn.edu>)

Copyright:: 2012-2013

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.