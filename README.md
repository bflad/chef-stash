# DESCRIPTION:

Installs Atlassian Stash.

_NOTE: THIS COOKBOOK IS CURRENTLY UNDER HEAVY ACTIVE DEVELOPMENT_
_AND NOT RECOMMENDED FOR EVEN BETA TESTING YET._

# REQUIREMENTS:

## Cookbooks:

Opscode Cookbooks (http://github.com/opscode-cookbooks/)

* git (once COOK-1537 is incorporated, otherwise use git cookbook fork below)
* java
* mysql
* postgresql

Third-Party Cookbooks

* git::source from https://github.com/bflad/git (until COOK-1537 is incorporated)

# USAGE:

Create a stash/stash encrypted data bag with the following information per
Chef environment:
* _required:_ database type (mysql/postgresql), host (FQDN/localhost),
name, user, password
* _optional:_ database port
* _optional:_ Tomcat HTTPS Java Keystore keyAlias, keystoreFile, keystorePass
(defaults to self-signed)

Repeat for other Chef environments as necessary. Example:

    {
      "id": "stash"
      "development": {
        "database": {
          "type": "postgres",
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

Add recipe[stash] to your run_list and get on your merry way. If it is a
localhost database, it will automatically set up the database server, 
create the database, and assign database user permissions (along with
approriate Stash configuration of course).

# LICENSE and AUTHOR:
      
Author:: Brian Flad (<bflad417@gmail.com>)

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