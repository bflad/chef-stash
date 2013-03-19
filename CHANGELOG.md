## v2.5.0

* Default to installing Stash 2.2.0
* Use new `node['stash']['home_path']/lib` directory support for persistent MySQL Connector/J library
* Set `node['build_essential']['compiletime'] = true` to ensure build tools are ready
* Oracle JDK 7 for Vagrant testing

## v2.4.0

* Added Perl dependency (required for Stash 2.X)
* Ubuntu 12.04 support
* Better handling of apache2 listen_ports in apache2 recipe

## v2.3.1

* Chef 11 fixes for apache2 recipe

## v2.3.0

* Stash 2.x support
* Bumped default Stash installation to 2.1.1

## v2.2.0

* Added Chef Solo support by refactoring settings into library function
* Refactored localhost database handling in default recipe
* Additional `node['stash']['database']` and `node['stash']['tomcat']` attributes from settings refactoring

## v2.1.8 ##

* Use generic database_user with provider for last MySQL fix

## v2.1.7 ##

* On MySQL, drop anonymous localhost user due to MySQL issue

## v2.1.6 ##

* Made stash_deploy LWRP only updated if underlying Git resource was updated

## v2.1.5 ##

* Removed SSH URI default attribute to prevent caching issues with SSH hostname

## v2.1.4 ##

* Corrected ssh_wrapper.sh template

## v2.1.3 ##

* deploy LWRP s/owner/user/g for Git resource

## v2.1.2 ##

* deploy LWRP fixed action attribute to deploy_action so it can be passed through

## v2.1.1 ##

* Set deploy_key cookbook for ssh_wrapper.sh template to stash

## v2.1.0 ##

* Added `stash_deploy` and `stash_deploy_key` LWRPs
* Added SSH attributes

## v2.0.2

* Fixed location of stash-config.properties

## v2.0.1

* Renamed service in upgrade recipe to prevent resource caching issues
* Fixed service notifications in default recipe
* Subscribed stash service to java_ark[jdk] updates

## v2.0.0

* Uses mysql_connector cookbook for handling MySQL Connector/J installation
* stash::upgrade recipe now just calls stash::default rather than duplicating
  code
* Includes git::source recipe on "rhel" platform_family since Git package
  version is not new enough
* Refactored to use apache2 cookbook web_app

## v1.0.3

* Fixes broken apache VirtualHost minitest

## v1.0.2

* Includes initial minitests

## v1.0.1

* Fixes installation existance check from change in Stash 1.3

## v1.0.0

* Ready for production, supports Stash 1.3
* Fixed upgrade recipe template names
* Documentation updated for actual functionality

## v0.2.16

* Renamed upgrade template blocks to prevent caching issues

## v0.2.15

* Fixed loading all encrypted databag objects for upgrade recipe

## v0.2.14

* Added templates to upgrade recipe

## v0.2.13

* Renamed upgrade recipe execute block description to prevent caching issue

## v0.2.12

* FC001: Use strings in preference to symbols to access node attributes

## v0.2.11

* Removing install directory before copying new Stash version directory

## v0.2.10

* Fixed home directory backup
* Forcing overwrite with mv -f for new Stash version directory

## v0.2.9

* Added encrypted data bag retrieval for stash::upgrade

## v0.2.8

* Bump default Stash version to 1.2.3

## v0.2.7

* Fixing localhost MySQL host since mysql::server doesn't appear to work with
  localhost and MySQL Connector/J

## v0.2.6

* Added host parameter for mysql database user grant to fix bind-address issue

## v0.2.5

* Refactored and fixed database and database user provider handling

## v0.2.4

* Misspelled MySQL collation for localhost database creation

## v0.2.3

* Fix for Integer default port for database cookbook

## v0.2.2

* Community cookbooks now including specific recipes for database resource usage

## v0.2.1

* Fix for localhost database_connection merging

## v0.2.0

* Initial upgrade recipe

## v0.1.0

* Initial beta release with default and Apache recipes.
