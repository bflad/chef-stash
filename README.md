# chef-stash  [![Build Status](https://secure.travis-ci.org/bflad/chef-stash.png?branch=master)](http://travis-ci.org/bflad/chef-stash)

## Description

Installs/Configures [Atlassian Stash](https://www.atlassian.com/software/stash/) / [Atlassian Bitbucket](https://www.atlassian.com/software/bitbucket/) server and [Atlassian Stash Backup Client](https://marketplace.atlassian.com/plugins/com.atlassian.stash.backup.client). Provides LWRPs for code deployment via Stash as well as for hook and repository management. Please see [COMPATIBILITY.md](COMPATIBILITY.md) for more information about Stash releases (versions and checksums) that are tested and supported by cookbook versions.

## Requirements

### Platforms

* CentOS 6, 7
* RHEL 6, 7
* Ubuntu 12.04, 14.04

### Chef

* Version 5.X of cookbook requires Chef 13

### Databases

* HSQLDB (not recommended for production usage)
* Microsoft SQL Server
* MySQL
* Postgres

### Cookbooks

Required [Opscode Cookbooks](https://github.com/opscode-cookbooks/)

* [apache2](https://github.com/opscode-cookbooks/apache2) (if using Apache 2 proxy)
* [ark](https://github.com/opscode-cookbooks/ark)
* [cron](https://github.com/opscode-cookbooks/cron)
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
checksum | SHA256 checksum for Stash install | String | auto-detected (see attributes/default.rb)
home_path | home data directory for Stash user | String | /var/atlassian/application-data/bitbucket (if upgrading from 3.x cookbook it will be /var/atlassian/application-data/stash)
install_path | location to install Stash | String | /opt/atlassian
install_type | Stash install type - "standalone" only for now | String | standalone
url_base | URL base for Stash install | String | http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash
url | URL for Stash install | String | auto-detected (see attributes/default.rb)
user | user to run Stash | String | stash
version | Stash version to install | String | 5.9.0

### Stash Backup Attributes (Shared)

These attributes are under the `node['stash']['backup']` namespace. Some of these attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists.

Attribute | Description | Type | Default
----------|-------------|------|--------
backup_path | Path for backups | String | /tmp
baseurl | Stash base URL | String | `https://#{node['fqdn']}/`
password | Stash administrative user password | String | changeit
strategy | [Stash backup strategy](https://confluence.atlassian.com/display/STASH/Data+recovery+and+backups#Datarecoveryandbackups-TwowaystobackupStash): 'backup_client' or 'backup_diy' | String | backup_client
user | Stash administrative user | String | admin

### Stash Backup Client Attributes
Documentation: [Using the Stash Backup Client](https://confluence.atlassian.com/display/STASH/Using+the+Stash+Backup+Client)

These attributes are under the `node['stash']['backup_client']` namespace. Some of these attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists.

Attribute | Description | Type | Default
----------|-------------|------|--------
checksum | SHA256 checksum for Stash Backup Client install | String | auto-detected (see attributes/default.rb)
install_path | location to install Stash Backup Client | String | /opt/atlassian/stash-backup-client
url_base | URL base for Stash Backup Client install | String | http://downloads.atlassian.com/software/stash/downloads/stash-backup-distribution
version | Stash Backup Client version to install | String | 3.3.4

### Stash DIY Backup Attributes
Documentation: [Using Stash DIY Backup](https://confluence.atlassian.com/display/STASH/Using+Stash+DIY+Backup)

These attributes are under the `node['stash']['backup_diy']` namespace. Some of these attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists.

Attribute | Description | Type | Default
----------|-------------|------|--------
backup_archive_type | The way how to backup the stash home | String | tar
backup_home_type | The way how to backup the stash home | String | rsync
exclude_repos | List of repo IDs which should be excluded from the backup | List | []
gpg_recipient | GPG recipient name (only if `['backup_archive_type]'` is `'tar-gpg'`) | String | ""
install_path | location to place Stash DIY Backup scripts | String | /opt/atlassian/stash-diy-backup
hipchat_room | HipChat room where notifications should be sent | String | ""
hipchat_token | Authorization token for the HipChat server | String | ""
hipchat_url | URL to the HipChat server for sending notifications | String | 'https://api.hipchat.com'
repo_url | Git repository URL where Stash DIY Backup scripts are stored | String | https://bitbucket.org/atlassianlabs/atlassian-stash-diy-backup.git
revision | Git revision (or a branch, or a tag) wich should be checked out | String | master
temp_path | A temporary path where backup essentials should be placed before packing to the archive | String | /tmp/stash-backup-temp
verbose | Should the script output be verbose or not | Boolean | true

### Stash Backup Cron Attributes

These attributes are under the `node['stash']['backup']['cron']` namespace. All of these attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists.

Attribute | Description | Type | Default
----------|-------------|------|--------
enable | Configure cron job to backup Stash periodically | Boolean | false
day | Day of month | String | *
hour | Hour of day | String | 0
minute | Minute of hour | String | 0
month | Month of year | String | *
weekday | Day of week | String | *

### Stash Database Attributes

_The default database will be changing to postgresql when cookbook 4.x is released._

All of these `node['stash']['database']` attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists

Attribute | Description | Type | Default
----------|-------------|------|--------
host | FQDN or "127.0.0.1" (127.0.0.1 automatically installs `['database']['type']` server) | String | 127.0.0.1
name | Stash database name | String | stash
password | Stash database user password | String | changeit
port | Stash database port | String | 5432
testInterval | Stash database pool idle test interval in minutes | Fixnum | 2
type | Stash database type - "hsqldb" (not recommended), "mysql", "postgresql", or "sqlserver" | String | postgresql
user | Stash database user | String | stash
query_string | jdbc query string to append to the end of a JDBC url | String | empty

### Stash JVM Attributes

These attributes are under the `node['stash']['jvm']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
minimum_memory | JVM minimum memory | String | 512m
maximum_memory | JVM maximum memory | String | 768m
maximum_permgen | JVM maximum PermGen memory | String | 384m
java_opts | additional JAVA_OPTS to be passed to Stash JVM during startup | String | ""
support_args | additional JAVA_OPTS recommended by Atlassian support for Stash JVM during startup | String | ""

### Stash Property Attributes

_The usage of `node['stash']['plugin']` for properties is deprecated in 3.x of the cookbook and may change or be removed in 4.x_

All of these `node['stash']['properties']` attributes are overridden by `stash/stash` encrypted data bag (Hosted Chef) or data bag (Chef Solo), if it exists.

Attribute | Description | Type | Default
----------|-------------|------|--------
`key` | A key/value pair to be inserted into stash-config.properties as `key`=`value` | Hash | {}

### Stash SSH Attributes ###

These attributes are under the `node['stash']['ssh']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
hostname | Stash SSH hostname | String | `node['fqdn']`
port | Stash SSH port | Fixnum | 7999
uri | Stash SSH URI | String | `ssh://git@#{node['stash']['ssh']['hostname']}:#{node['stash']['ssh']['port']}`

### Stash Tomcat Attributes

These attributes are under the `node['stash']['tomcat']` namespace.

Attribute | Description | Type | Default
----------|-------------|------|--------
port | Tomcat HTTP port | Fixnum | 7990

## Recipes

* `recipe[stash]` Installs Atlassian Stash with built-in Tomcat and Apache 2 proxy
* `recipe[stash::apache2]` Installs/configures Apache 2 proxy for Stash (ports 80/443)
* `recipe[stash::backup_client]` Installs/configures Atlassian Stash Backup Client
* `recipe[stash::backup_client_cron]` Installs/configures Atlassian Stash Backup Client cron.d
* `recipe[stash::configuration]` Configures Stash's settings
* `recipe[stash::database]` Installs/configures MySQL/Postgres server, database, and user for Stash
* `recipe[stash::linux_standalone]` Installs/configures Stash via Linux standalone archive
* `recipe[stash::service_init]` Installs/configures Stash init service
* `recipe[stash::tomcat_configuration]` Configures Stash's built-in Tomcat

## LWRPs

* `stash_deploy` - wrapper Git resource for using a `stash_deploy_key`, project, and repository for code deployment
* `stash_deploy_key` - creates SSH private key file and SSH wrapper for code deployment
* `hook` - Wrapper to enable/disable/configure a stash hook (requires the user account password to be in chef-vault)
* `repo` - Wrapper to create/delete a stash repository (requires the user account password to be in chef-vault)

## Usage

### Stash Server Data Bag

For security purposes it is recommended to use data bag for storing secrets
like passwords and database credentials.

You can override any attributes from the `['stash']` namespace using the
`stash/stash` data bag. It could be either encrypted or not
encrypted by your choice.

Example:
```json
{
  "id": "stash",
  "stash": {
    "database": {
      "type": "postgresql",
      "host": "127.0.0.1",
      "name": "stash",
      "user": "stash",
      "password": "stash_db_password",
    }
  }
}
```
_(Note - `"stash"` nesting level is required!)_

These credentials will be used for your stash installation instead of
appropriate attribute values.

Data bag's and item's names are optional and can be changed by overriding
attributes `['stash']['data_bag_name']` and `['stash']['data_bag_item']`

### Stash Server Default Installation

* Optionally use (un)encrypted data bag or set attributes
  * `knife data bag create stash`
  * `knife data bag edit stash stash --secret-file=path/to/secret`
* Add `recipe[stash]` to your node's run list.

### Stash Backup Client Installation

* Optionally use (un)encrypted data bag or set attributes
  * `knife data bag create stash`
  * `knife data bag edit stash stash --secret-file=path/to/secret`
* Add `recipe[stash]['backup_client']` to your node's run list.

### Stash Backup Client Cron Installation

* Optionally use (un)encrypted data bag or set attributes
  * `knife data bag create stash`
  * `knife data bag edit stash stash --secret-file=path/to/secret`
* Add `recipe[stash]['backup_client_cron']` to your node's run list.

### Code Deployment From Stash

* Ensure your node has Git installed
* Create a `stash_deploy_key` with the SSH private key contents (using `\n` for newlines) of a Stash user with permissions to your repository.

For example:

    stash_deploy_key "deployment_user" do
      key "-----BEGIN RSA PRIVATE KEY-----\nMIIEpQIB..."
    end

* In this example, now you can either directly use the ssh_wrapper available at `#{node['stash']['install_path']}/deployment_user_ssh_wrapper.sh` or use the `stash_deploy` LWRP.

Such as:

    stash_deploy "/opt/shibboleth-idp/conf" do
      deploy_key "deployment_user"
      project "SHIBIDP"
      repository "configuration"
    end

## Testing and Development

Here's how you can quickly get testing or developing against the cookbook thanks to [Vagrant](http://vagrantup.com/) and [Berkshelf](http://berkshelf.com/).

    vagrant plugin install vagrant-berkshelf
    vagrant plugin install vagrant-cachier
    vagrant plugin install vagrant-omnibus
    git clone git://github.com/bflad/chef-stash.git
    cd chef-stash
    vagrant up BOX # BOX being centos5, centos6, debian7, fedora18, fedora19, fedora20, freebsd9, ubuntu1204, ubuntu1210, ubuntu1304, or ubuntu1310

You need to add the following hosts entries:

* 192.168.50.10 stash-centos-6
* 192.168.50.10 stash-ubuntu-1204
* (etc.)

The running Stash server is accessible from the host machine:

CentOS 6 Box:
* Web UI: https://stash-centos-6/
* Stash SSH: ssh://git@stash-centos-6:7999/

Ubuntu 12.04 Box:
* Web UI: https://stash-ubuntu-1204/
* Stash SSH: ssh://git@stash-ubuntu-1204:7999/

You can then SSH into the running VM using the `vagrant ssh BOX` command.

The VM can easily be stopped and deleted with the `vagrant destroy` command. Please see the official [Vagrant documentation](http://docs.vagrantup.com/v2/cli/index.html) for a more in depth explanation of available commands.

### Test Kitchen

Please see documentation in: [TESTING.md](TESTING.md)

## Contributing

Please use standard Github issues/pull requests and if possible, in combination with testing on the Vagrant boxes.

## License and Contributors

Please see license information in: [LICENSE](LICENSE)

* Brian Flad (<bflad417@gmail.com>)
* Kevin Moser (@moserke)
* Ramon Makkelie (@ramonskie)
* Martin (@martianus)
* Mikhail Zholobov (@legal90)
* Claudio Rivabene (@crivabene)
* Patrick Connolly (@patcon)
* Benjamin Neff (@SuperTux88)
* Anna Tikhonova (@atikhono)
* Alex Karasik (@akarasik)
* Andrei Skopenko (@scopenco)
* Kate Lynn (@katbyte)
* Lincoln Lee (@linc01n)
