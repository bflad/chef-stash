# chef-stash  [![Build Status](https://secure.travis-ci.org/bflad/chef-stash.png?branch=master)](http://travis-ci.org/bflad/chef-stash)

# DESCRIPTION:

Installs/Configures Atlassian Stash.

# REQUIREMENTS:

## Cookbooks:

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* apache2 (if using Apache 2 proxy)
* database
* git
* java
* mysql
* postgresql

# USAGE:

## Recipes

* _recipe[stash]:_ Installs Atlassian Stash with built-in Tomcat
* _recipe[stash::apache2]:_ Installs above with Apache 2 proxy (ports 80/443)
* _recipe[stash::upgrade]:_ Upgrades Atlassian Stash

## Required Data Bag

Create a stash/stash encrypted data bag with the following information per
Chef environment:
* _required:_ database type (mysql/postgresql), host (FQDN/localhost),
name, user, password
* _optional:_ configuration license
* _optional:_ database port
* _optional:_ Tomcat HTTPS Java Keystore keyAlias, keystoreFile, keystorePass
(defaults to self-signed)

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

Add `recipe[stash]` to your run_list and get on your merry way.

_PLEASE NOTE:_ Due to how Stash handles the setup process, you will
still be asked for database information when initially setting up the
server. I submitted [STASH-2687](https://jira.atlassian.com/browse/STASH-2687)
to fix this.

## More Data Bag Information:

_DATABASE:_ If it is a localhost database, it will automatically set up
the database server, create the database, and assign database user 
permissions (along with approriate Stash configuration of course).

_LICENSE:_ If entered, will automatically enter license into database.
Can be left blank if you need to generate evaluation license.

# LICENSE and AUTHOR:
      
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