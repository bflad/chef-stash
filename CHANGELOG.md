## 3.1.1

* Stash database connection fix for localhost MySQL setup with bind_address set to 0.0.0.0 

## 3.1.0

* Default to Stash 2.8.2
* Switch subscribes to string notation in service_init recipe

## 3.0.1

* Syntax adjustment to Hash diff helper method to support Ruby 1.8

## 3.0.0

### 3.0.0 Major Changes

#### Additions

* Cookbook dependency: ark (handling downloads and extracting)
* Recipe: default (installs backup_client recipe -- use backup_client_cron if you'd like it automatically running via cron)
* Attribute: `node['stash']['install_type']` (possible future usage, defaults to standalone)
* Attribute: `node['stash']['service_type']` (possible future usage, defaults to init)

#### Removals

* Recipe: upgrade (ark handles symlinks automatically and use Stash Backup Client for backups)
* Attribute `node['stash']['backup_home']` (use Stash Backup Client instead)
* Attribute `node['stash']['backup_install']` (use Stash Backup Client instead)
* Attribute `node['stash']['home_backup']` (use Stash Backup Client instead)
* Attribute `node['stash']['install_backup']` (use Stash Backup Client instead)

#### Modifications

* apache2 recipe: no longer includes default recipe
* Attribute renamed:
  * From: `node['stash']['run_user']`
  * To: `node['stash']['user']`
  * Reasoning: Consistency with other cookbooks
* Attribute default: `node['stash']['home_path']`
  * From: /home/stash
  * To: /var/atlassian/application-data/stash
  * Reasoning: Match Atlassian recommendations
  * See Migrating home_path and install_path section for manual steps to perform cookbook upgrade
* Attribute default: `node['stash']['home_path']`
  * From: /opt/atlassian-stash
  * To: /opt/atlassian (symlinks /opt/atlassian/stash-X.Y.Z to /opt/atlassian/stash)
  * Reasoning: Match Atlassian recommendations
  * See Migrating home_path and install_path section for manual steps to perform cookbook upgrade
* Attributes moved:
  * From: apache2.rb
  * To: default.rb
* default recipe: separate recipes
  * configuration
  * database
  * linux_standalone
  * service_init
  * tomcat_configuration

#### Migrating home_path and install_path

To switch to new defaults:
  * Ensure Chef client won't run (service chef-client stop, etc.)
  * service stash stop
  * mkdir -p /var/atlassian/application-data
  * usermod -d /var/atlassian/application-data/stash -m stash
  * mkdir /opt/atlassian
  * mv /opt/atlassian-stash /opt/atlassian/stash-X.Y.Z
  * ln -s /opt/atlassian/stash-X.Y.Z /opt/atlassian/stash
  * Start Chef client again (service chef-client start, etc.)

### 3.0.0 Minor Changes

* Update COMPATIBILITY.md to easier to read format and migrate checksums to default attributes
* Added vagrant-cachier to Vagrantfile
* Added ubuntu1210 and ubuntu1304 to Test Kitchen and Vagrantfile
* Added TESTING.md for documentation about Test Kitchen
* Added Guardfile
* Added .rubocop.yml
* Bump Gemfile.ci to Chef 11.6.0
* Move all licensing statements to LICENSE

## 2.21.0

* Add plugin attributes/databag items for insertion into stash-config.properties

## 2.20.0

* Default to Stash 2.8.1
* Default to Stash Backup Client 1.0.0 (with new download URL)

## 2.19.0

* Add backup_client and backup_client_cron recipes for installing/configuring [Atlassian Stash Backup Client](https://marketplace.atlassian.com/plugins/com.atlassian.stash.backup.client)
* Add [cron cookbook](https://github.com/opscode-cookbooks/cron) dependency

## 2.18.0

* Bump default Stash version to 2.7.0

## 2.17.0

* Initial HSQLDB support (not recommended for production)
  * Only need to set "hsqldb" for `node['stash']['database']['type']` and select internal database on setup

## 2.16.0

* Bump default Stash version to 2.6.3

## 2.15.0

* Bump default Stash version to 2.6.0

## 2.14.0

* Bump default Stash version to 2.5.0

## 2.13.0

* Bump default Stash version to 2.4.2

## 2.12.0

* Bump default Stash version to 2.4.1

## 2.11.0

* Add default sqlserver port to settings library
* Tested support for Microsoft SQL Server

## 2.10.1

* Add LWRP update notifications

## 2.10.0

* Add `hook` LWRP for interfacing with Stash hooks
* Add `repo` LWRP for interfacing with Stash repositories

## 2.9.0

* Bump default Stash version to 2.4.0
* Fix run_user attribute ordering

## 2.8.0

* Checksum attribute auto-detection
* Added url_base attribute

## 2.7.0

* Untested support for Microsoft SQL server

## 2.6.1

* Bump default Stash to 2.3.1

## 2.6.0

* Default to installing Stash 2.3.0
* Updated Vagrant box URLs to Chef 11.2.0 since tested and works

## 2.5.0

* Default to installing Stash 2.2.0
* Use new `node['stash']['home_path']/lib` directory support for persistent MySQL Connector/J library
* Set `node['build_essential']['compiletime'] = true` to ensure build tools are ready
* Oracle JDK 7 for Vagrant testing

## 2.4.0

* Added Perl dependency (required for Stash 2.X)
* Ubuntu 12.04 support
* Better handling of apache2 listen_ports in apache2 recipe

## 2.3.1

* Chef 11 fixes for apache2 recipe

## 2.3.0

* Stash 2.x support
* Bumped default Stash installation to 2.1.1

## 2.2.0

* Added Chef Solo support by refactoring settings into library function
* Refactored localhost database handling in default recipe
* Additional `node['stash']['database']` and `node['stash']['tomcat']` attributes from settings refactoring

## 2.1.8 ##

* Use generic database_user with provider for last MySQL fix

## 2.1.7 ##

* On MySQL, drop anonymous localhost user due to MySQL issue

## 2.1.6 ##

* Made stash_deploy LWRP only updated if underlying Git resource was updated

## 2.1.5 ##

* Removed SSH URI default attribute to prevent caching issues with SSH hostname

## 2.1.4 ##

* Corrected ssh_wrapper.sh template

## 2.1.3 ##

* deploy LWRP s/owner/user/g for Git resource

## 2.1.2 ##

* deploy LWRP fixed action attribute to deploy_action so it can be passed through

## 2.1.1 ##

* Set deploy_key cookbook for ssh_wrapper.sh template to stash

## 2.1.0 ##

* Added `stash_deploy` and `stash_deploy_key` LWRPs
* Added SSH attributes

## 2.0.2

* Fixed location of stash-config.properties

## 2.0.1

* Renamed service in upgrade recipe to prevent resource caching issues
* Fixed service notifications in default recipe
* Subscribed stash service to java_ark[jdk] updates

## 2.0.0

* Uses mysql_connector cookbook for handling MySQL Connector/J installation
* stash::upgrade recipe now just calls stash::default rather than duplicating
  code
* Includes git::source recipe on "rhel" platform_family since Git package
  version is not new enough
* Refactored to use apache2 cookbook web_app

## 1.0.3

* Fixes broken apache VirtualHost minitest

## 1.0.2

* Includes initial minitests

## 1.0.1

* Fixes installation existance check from change in Stash 1.3

## 1.0.0

* Ready for production, supports Stash 1.3
* Fixed upgrade recipe template names
* Documentation updated for actual functionality

## 0.2.16

* Renamed upgrade template blocks to prevent caching issues

## 0.2.15

* Fixed loading all encrypted databag objects for upgrade recipe

## 0.2.14

* Added templates to upgrade recipe

## 0.2.13

* Renamed upgrade recipe execute block description to prevent caching issue

## 0.2.12

* FC001: Use strings in preference to symbols to access node attributes

## 0.2.11

* Removing install directory before copying new Stash version directory

## 0.2.10

* Fixed home directory backup
* Forcing overwrite with mv -f for new Stash version directory

## 0.2.9

* Added encrypted data bag retrieval for stash::upgrade

## 0.2.8

* Bump default Stash version to 1.2.3

## 0.2.7

* Fixing localhost MySQL host since mysql::server doesn't appear to work with
  localhost and MySQL Connector/J

## 0.2.6

* Added host parameter for mysql database user grant to fix bind-address issue

## 0.2.5

* Refactored and fixed database and database user provider handling

## 0.2.4

* Misspelled MySQL collation for localhost database creation

## 0.2.3

* Fix for Integer default port for database cookbook

## 0.2.2

* Community cookbooks now including specific recipes for database resource usage

## 0.2.1

* Fix for localhost database_connection merging

## 0.2.0

* Initial upgrade recipe

## 0.1.0

* Initial beta release with default and Apache recipes.
