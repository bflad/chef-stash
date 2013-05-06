# chef-stash  [![Build Status](https://secure.travis-ci.org/bflad/chef-stash.png?branch=master)](http://travis-ci.org/bflad/chef-stash)

## Description

Installs/Configures Atlassian Stash server. Provides LWRPs for code deployment via Stash. Please see [COMPATIBILITY.md](COMPATIBILITY.md) for more information about Stash releases (versions and checksums) that are tested and supported by cookbook versions.

## Requirements

### Platforms

* CentOS 6
* RedHat 6
* Ubuntu 12.04

### Databases

* Microsoft SQL Server (untested)
* MySQL
* Postgres

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [apache2](https://github.com/opscode-cookbooks/apache2) (if using Apache 2 proxy)
* [database](https://github.com/opscode-cookbooks/database)
* [git](https://github.com/opscode-cookbooks/git)
* [java](https://github.com/opscode-cookbooks/java)
* [mysql](https://github.com/opscode-cookbooks/mysql) (if using MySQL database)
* [perl](https://github.com/opscode-cookbooks/perl)
* [postgresql](https://github.com/opscode-cookbooks/postgresql) (if using Postgres database)

Third-Party Cookbooks

* [mysql_connector](https://github.com/bflad/chef-mysql_connector) (if using MySQL database)

## Attributes

These attributes are under the `node['stash']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
backup_home | backup home directory during upgrade | Boolean | true
backup_install | backup install directory during upgrade | Boolean | true
checksum | SHA256 checksum for Stash install | String | auto-detected (see attributes/default.rb)
home_backup | location of home directory backup during upgrade | String | /tmp/atlassian-stash-home-backup.tgz
home_path | home directory for Stash user | String | `/home/#{node['stash']['run_user']}`
install_backup | location of install directory backup during upgrade | String | /tmp/atlassian-stash-backup.tgz
install_path | location to install Stash | String | /opt/atlassian-stash
run_user | user to run Stash | String | stash
url_base | URL base for Stash install | String | http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash
url | URL for Stash install | String | auto-detected (see attributes/default.rb)
version | Stash version to install (use `recipe[stash::upgrade]` to upgrade to version defined) | String | 2.3.1

### Stash Database Attributes

All of these `node['stash']['database']` attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
host | FQDN or "localhost" (localhost automatically installs `['database']['type']` server) | String | localhost
name | Stash database name | String | stash
password | Stash database user password | String | changeit
port | Stash database port | Fixnum | 3306
type | Stash database type - "mysql", "postgresql", or "sqlserver" | String | mysql
user | Stash database user | String | stash

### Stash JVM Attributes

These attributes are under the `node['stash']['jvm']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
minimum_memory | JVM minimum memory | String | 512m
maximum_memory | JVM maximum memory | String | 768m
maximum_permgen | JVM maximum PermGen memory | String | 256m
java_opts | additional JAVA_OPTS to be passed to Stash JVM during startup | String | ""
support_args | additional JAVA_OPTS recommended by Atlassian support for Stash JVM during startup | String | ""

### Stash SSH Attributes ###

These attributes are under the `node['stash']['ssh']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
hostname | Stash SSH hostname | String | `node['fqdn']`
port | Stash SSH port | Fixnum | 7999
uri | Stash SSH URI | String | `ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}`

### Stash Tomcat Attributes

These attributes are under the `node['stash']['tomcat']` namespace.

Any `node['stash']['tomcat']['key*']` attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
keyAlias | Tomcat SSL keystore alias | String | tomcat
keystoreFile | Tomcat SSL keystore file - will automatically generate self-signed keystore file if left as default | String | `#{node['stash']['home_path']}/.keystore`
keystorePass | Tomcat SSL keystore passphrase | String | changeit
port | Tomcat HTTP port | Fixnum | 7990
ssl_port | Tomcat HTTPS port | Fixnum | 8443

## Recipes

* `recipe[stash]` Installs Atlassian Stash with built-in Tomcat
* `recipe[stash::apache2]` Installs above with Apache 2 proxy (ports 80/443)
* `recipe[stash::upgrade]` Upgrades Atlassian Stash

## LWRPs

* `stash_deploy` - wrapper Git resource for using a `stash_deploy_key`, project, and repository for code deployment
* `stash_deploy_key` - creates SSH private key file and SSH wrapper for code deployment
* `hook` - Wrapper to enable/disable/configure a stash hook (requires the user account password to be in chef-vault)
* `repo` - Wrapper to create/delete a stash repository (requires the user account password to be in chef-vault)

## Usage

### Stash Server Data Bag

For securely overriding attributes on Hosted Chef, create a `stash/stash` encrypted data bag with the model below. Chef Solo can override the same attributes with a `stash/stash` unencrypted data bag of the same information.

_required:_
* `['database']['type']` "mysql", "postgresql", or "sqlserver"
* `['database']['host']` FQDN or "localhost" (localhost automatically
  installs `['database']['type']` server)
* `['database']['name']` Name of Stash database
* `['database']['user']` Stash database username
* `['database']['password']` Stash database username password

_optional:_
* `['database']['port']` Database port, standard database port for
  `['database']['type']`
* `['tomcat']['keyAlias']` Tomcat HTTPS Java Keystore keyAlias, defaults to self-signed certifcate
* `['tomcat']['keystoreFile']` Tomcat HTTPS Java Keystore keystoreFile, self-signed certificate
* `['tomcat']['keystorePass']` Tomcat HTTPS Java Keystore keystorePass, self-signed certificate

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

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    gem install bundler --no-ri --no-rdoc
    git clone git://github.com/bflad/chef-stash.git
    cd chef-stash
    bundle install
    bundle exec vagrant up BOX # BOX being centos6 or ubuntu1204

You need to add the following hosts entries:

* 192.168.50.10 stash-centos-6
* 192.168.50.11 stash-ubuntu-1204

The running Stash server is accessible from the host machine:

CentOS 6 Box:
* Web UI: https://stash-centos-6/
* Stash SSH: ssh://git@stash-centos-6:7999/

Ubuntu 12.04 Box:
* Web UI: https://stash-ubuntu-1204/
* Stash SSH: ssh://git@stash-ubuntu-1204:7999/

You can then SSH into the running VM using the `vagrant ssh` command.
The VM can easily be stopped and deleted with the `vagrant destroy`
command. Please see the official [Vagrant documentation](http://vagrantup.com/v1/docs/commands.html)
for a more in depth explanation of available commands.

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

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