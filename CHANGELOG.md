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
