# Change Log

## [5.0.0](https://github.com/bflad/chef-stash/tree/5.0.0) (2018-04-01)

[Full Changelog](https://github.com/bflad/chef-stash/compare/4.5.2...5.0.0)

**Fixed bugs:**

- Incompatibility with Bitbucket 5 [\#181](https://github.com/bflad/chef-stash/issues/181)
- Compatability.md is severely out of date. [\#164](https://github.com/bflad/chef-stash/issues/164)

**Closed issues:**

- is this file /templates/default/web\_app.conf.erb used any longer [\#178](https://github.com/bflad/chef-stash/issues/178)
- Changes to version attribute not reflected in url or checksum. [\#167](https://github.com/bflad/chef-stash/issues/167)

**Merged pull requests:**

- Remove use\_inline\_resource [\#190](https://github.com/bflad/chef-stash/pull/190) ([linc01n](https://github.com/linc01n))
- Update bitbucket to 5.9.0 [\#189](https://github.com/bflad/chef-stash/pull/189) ([linc01n](https://github.com/linc01n))
- Return non 0 rc for status if bitbucket is not running [\#188](https://github.com/bflad/chef-stash/pull/188) ([akarasik](https://github.com/akarasik))
- Bitbucket 5 support [\#186](https://github.com/bflad/chef-stash/pull/186) ([jtusz](https://github.com/jtusz))

## [4.5.2](https://github.com/bflad/chef-stash/tree/4.5.2) (2017-06-14)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.5.1...4.5.2)

**Implemented enhancements:**

- Fix rubocop offenses [\#165](https://github.com/bflad/chef-stash/pull/165) ([linc01n](https://github.com/linc01n))

**Closed issues:**

- Allow SSL from the application to the database [\#159](https://github.com/bflad/chef-stash/issues/159)

**Merged pull requests:**

-  Prepare for 4.5.2 cookbook release [\#185](https://github.com/bflad/chef-stash/pull/185) ([linc01n](https://github.com/linc01n))
- Fix ruby syntax error [\#184](https://github.com/bflad/chef-stash/pull/184) ([linc01n](https://github.com/linc01n))
- Added checksums for versions 4.9.0 --\> 4.14.5 [\#183](https://github.com/bflad/chef-stash/pull/183) ([linc01n](https://github.com/linc01n))
- Fix foodcritic and rubocop [\#182](https://github.com/bflad/chef-stash/pull/182) ([linc01n](https://github.com/linc01n))
- Fix travis errors [\#177](https://github.com/bflad/chef-stash/pull/177) ([linc01n](https://github.com/linc01n))
- Enable setting the session timeout [\#172](https://github.com/bflad/chef-stash/pull/172) ([akarasik](https://github.com/akarasik))
- Don't redirect /server-status for monitoring systems [\#170](https://github.com/bflad/chef-stash/pull/170) ([scopenco](https://github.com/scopenco))
- Moved checksum's and download url calculation into helper.rb  [\#169](https://github.com/bflad/chef-stash/pull/169) ([katbyte](https://github.com/katbyte))
- Added versions 4.6.1, 4.6.3, 4.7.1, 4.8.0, 4.8.1, 4.8.2, 4.8.3 [\#166](https://github.com/bflad/chef-stash/pull/166) ([katbyte](https://github.com/katbyte))

## [4.5.1](https://github.com/bflad/chef-stash/tree/4.5.1) (2016-06-10)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.5.0...4.5.1)

**Fixed bugs:**

- Code search is not working in 4.6.0 [\#156](https://github.com/bflad/chef-stash/issues/156)

**Merged pull requests:**

- Prepare for 4.5.1 cookbook release [\#163](https://github.com/bflad/chef-stash/pull/163) ([linc01n](https://github.com/linc01n))
- Update bitbucket to 4.6.2 [\#162](https://github.com/bflad/chef-stash/pull/162) ([linc01n](https://github.com/linc01n))
- Run start-bitbucket.sh with the full path in Bitbucket init script [\#158](https://github.com/bflad/chef-stash/pull/158) ([atikhono](https://github.com/atikhono))
- Bitbucket 4.6 needs set-bitbucket-home.sh and set-bitbucket-user.sh [\#157](https://github.com/bflad/chef-stash/pull/157) ([atikhono](https://github.com/atikhono))

## [4.5.0](https://github.com/bflad/chef-stash/tree/4.5.0) (2016-05-14)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.4.0...4.5.0)

**Closed issues:**

- Support Bitbucket 4.6 [\#153](https://github.com/bflad/chef-stash/issues/153)

**Merged pull requests:**

- Prepare for 4.5.0 cookbook release [\#155](https://github.com/bflad/chef-stash/pull/155) ([linc01n](https://github.com/linc01n))
- Update bitbucket to 4.6.0 and backup client to 3.2.0 [\#154](https://github.com/bflad/chef-stash/pull/154) ([linc01n](https://github.com/linc01n))

## [4.4.0](https://github.com/bflad/chef-stash/tree/4.4.0) (2016-04-25)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.3.0...4.4.0)

**Implemented enhancements:**

- Support multiple apache2 versions [\#150](https://github.com/bflad/chef-stash/pull/150) ([linc01n](https://github.com/linc01n))

**Merged pull requests:**

- Prepare for 4.4.0 cookbook release [\#152](https://github.com/bflad/chef-stash/pull/152) ([linc01n](https://github.com/linc01n))
- Update bitbucket to 4.5.2 and backup client to 3.1.0 [\#151](https://github.com/bflad/chef-stash/pull/151) ([linc01n](https://github.com/linc01n))
- Fix travis ruby version [\#149](https://github.com/bflad/chef-stash/pull/149) ([linc01n](https://github.com/linc01n))
- Fix apache listen ports attribute [\#148](https://github.com/bflad/chef-stash/pull/148) ([legal90](https://github.com/legal90))

## [4.3.0](https://github.com/bflad/chef-stash/tree/4.3.0) (2016-03-22)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.2.0...4.3.0)

**Fixed bugs:**

- Cannot use bitbucket backup client as the config namespace is wrong [\#143](https://github.com/bflad/chef-stash/issues/143)

**Merged pull requests:**

- Prepare for 4.3.0 cookbook release [\#147](https://github.com/bflad/chef-stash/pull/147) ([linc01n](https://github.com/linc01n))
- Update bitbucket to 4.4.1 and backup client to 3.0.0 [\#146](https://github.com/bflad/chef-stash/pull/146) ([linc01n](https://github.com/linc01n))
- Go to the directory contains backup.properties [\#145](https://github.com/bflad/chef-stash/pull/145) ([linc01n](https://github.com/linc01n))
- Rename properties for bitbucket backup client [\#144](https://github.com/bflad/chef-stash/pull/144) ([linc01n](https://github.com/linc01n))

## [4.2.0](https://github.com/bflad/chef-stash/tree/4.2.0) (2016-02-14)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.1.0...4.2.0)

**Implemented enhancements:**

- Update the template for DIY backup [\#138](https://github.com/bflad/chef-stash/pull/138) ([legal90](https://github.com/legal90))

**Closed issues:**

- Support for Stash DIY backup - maybe? [\#63](https://github.com/bflad/chef-stash/issues/63)
- Discussion: change default database to PostgreSQL? [\#49](https://github.com/bflad/chef-stash/issues/49)

**Merged pull requests:**

- Prepare for 4.2.0 cookbook release [\#140](https://github.com/bflad/chef-stash/pull/140) ([linc01n](https://github.com/linc01n))
- Set database type when running mysql suite [\#139](https://github.com/bflad/chef-stash/pull/139) ([linc01n](https://github.com/linc01n))
- Redirect HTTP to HTTPS [\#137](https://github.com/bflad/chef-stash/pull/137) ([legal90](https://github.com/legal90))
- Disable https on the Tomcat side [\#136](https://github.com/bflad/chef-stash/pull/136) ([legal90](https://github.com/legal90))
- Add newer Bitbucket Server versions [\#135](https://github.com/bflad/chef-stash/pull/135) ([legal90](https://github.com/legal90))
- .kitchen.yml: Rename Vagrant boxes "chef" -\> "bento" [\#134](https://github.com/bflad/chef-stash/pull/134) ([legal90](https://github.com/legal90))

## [4.1.0](https://github.com/bflad/chef-stash/tree/4.1.0) (2016-01-20)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.0.1...4.1.0)

**Merged pull requests:**

- Prepare for 4.1.0 cookbook release [\#133](https://github.com/bflad/chef-stash/pull/133) ([linc01n](https://github.com/linc01n))
- Upgrade bitbucket to 4.3.0 and backup client to 2.0.2 [\#132](https://github.com/bflad/chef-stash/pull/132) ([linc01n](https://github.com/linc01n))

## [4.0.1](https://github.com/bflad/chef-stash/tree/4.0.1) (2016-01-01)
[Full Changelog](https://github.com/bflad/chef-stash/compare/4.0.0...4.0.1)

**Merged pull requests:**

- Prepare for 4.0.1 cookbook release [\#131](https://github.com/bflad/chef-stash/pull/131) ([linc01n](https://github.com/linc01n))
- Add Bitbucket versions 4.2.0 [\#130](https://github.com/bflad/chef-stash/pull/130) ([linc01n](https://github.com/linc01n))
- Update readme [\#129](https://github.com/bflad/chef-stash/pull/129) ([linc01n](https://github.com/linc01n))

## [4.0.0](https://github.com/bflad/chef-stash/tree/4.0.0) (2015-12-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.16.1...4.0.0)

**Implemented enhancements:**

- Move pid file to /var/run [\#100](https://github.com/bflad/chef-stash/issues/100)
- Need to upgrade the conf/web.xml for 3.10.0 [\#97](https://github.com/bflad/chef-stash/issues/97)
- Upgrade database/mysql/postgresql dependencies as necessary [\#58](https://github.com/bflad/chef-stash/issues/58)

**Fixed bugs:**

- Cannot install mysql-client 5.6 on Ubuntu 12.04 [\#111](https://github.com/bflad/chef-stash/issues/111)

**Closed issues:**

- make create directory recursive [\#117](https://github.com/bflad/chef-stash/issues/117)
- Need any new co-maintainers? [\#106](https://github.com/bflad/chef-stash/issues/106)
- Update test-kitchen tests [\#96](https://github.com/bflad/chef-stash/issues/96)

**Merged pull requests:**

- 4.0 release [\#128](https://github.com/bflad/chef-stash/pull/128) ([linc01n](https://github.com/linc01n))
- Set home path to 3.x default when it exists [\#127](https://github.com/bflad/chef-stash/pull/127) ([linc01n](https://github.com/linc01n))
- Fix hard-coded JAVA\_HOME ENV [\#125](https://github.com/bflad/chef-stash/pull/125) ([linc01n](https://github.com/linc01n))
- Upgrade bitbucket to 4.1.0 [\#124](https://github.com/bflad/chef-stash/pull/124) ([linc01n](https://github.com/linc01n))
- Upgrade bitbucket to 4.0.3 [\#122](https://github.com/bflad/chef-stash/pull/122) ([linc01n](https://github.com/linc01n))
- Add recursive folder creation to DIY backup [\#121](https://github.com/bflad/chef-stash/pull/121) ([linc01n](https://github.com/linc01n))
- Upgrade bitbucket to 4.0.2 [\#119](https://github.com/bflad/chef-stash/pull/119) ([linc01n](https://github.com/linc01n))
- Create backup folder recusively [\#118](https://github.com/bflad/chef-stash/pull/118) ([linc01n](https://github.com/linc01n))
- Add Bitbucket Server 4.0 Support [\#116](https://github.com/bflad/chef-stash/pull/116) ([SuperTux88](https://github.com/SuperTux88))
- fix rubocop offenses from master [\#115](https://github.com/bflad/chef-stash/pull/115) ([SuperTux88](https://github.com/SuperTux88))
- bump stash to the latest version [\#114](https://github.com/bflad/chef-stash/pull/114) ([ramonskie](https://github.com/ramonskie))
- Match Kitchen network config with Vagrantfile [\#113](https://github.com/bflad/chef-stash/pull/113) ([linc01n](https://github.com/linc01n))
- Switch to using MySQL 5.5 by default [\#112](https://github.com/bflad/chef-stash/pull/112) ([patcon](https://github.com/patcon))
- Add DIY backup and Move pid file [\#110](https://github.com/bflad/chef-stash/pull/110) ([linc01n](https://github.com/linc01n))
- Add postgresql test suite [\#107](https://github.com/bflad/chef-stash/pull/107) ([patcon](https://github.com/patcon))
- Migrate to serverspec tests [\#105](https://github.com/bflad/chef-stash/pull/105) ([patcon](https://github.com/patcon))
- Remove apache2 test-kitchen suite [\#104](https://github.com/bflad/chef-stash/pull/104) ([patcon](https://github.com/patcon))
- Update mysql cookbook \(6.x\) and database cookbook [\#103](https://github.com/bflad/chef-stash/pull/103) ([patcon](https://github.com/patcon))
- Move pid to /var/run/stash/catalina.pid [\#102](https://github.com/bflad/chef-stash/pull/102) ([linc01n](https://github.com/linc01n))
- Add and default to Stash 3.10.2 [\#101](https://github.com/bflad/chef-stash/pull/101) ([linc01n](https://github.com/linc01n))
- Upgrade web.xml to latest version [\#98](https://github.com/bflad/chef-stash/pull/98) ([linc01n](https://github.com/linc01n))

## [3.16.1](https://github.com/bflad/chef-stash/tree/3.16.1) (2015-06-20)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.16.0...3.16.1)

**Fixed bugs:**

- umask warning when restarting \(in vagrant ubuntu1404\) [\#92](https://github.com/bflad/chef-stash/issues/92)

**Merged pull requests:**

- Prepare for 3.16.1 cookbook release [\#94](https://github.com/bflad/chef-stash/pull/94) ([linc01n](https://github.com/linc01n))
- Set umask to 0027 for more secure file creation [\#93](https://github.com/bflad/chef-stash/pull/93) ([linc01n](https://github.com/linc01n))

## [3.16.0](https://github.com/bflad/chef-stash/tree/3.16.0) (2015-06-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.15.0...3.16.0)

**Fixed bugs:**

- Stash Crashes Due to java.lang.OutOfMemoryError PermGen Space Error [\#84](https://github.com/bflad/chef-stash/issues/84)

**Closed issues:**

- Vagrant failed for Ubuntu 1404 install [\#86](https://github.com/bflad/chef-stash/issues/86)

**Merged pull requests:**

- Prepare for 3.16.0 cookbook release [\#91](https://github.com/bflad/chef-stash/pull/91) ([linc01n](https://github.com/linc01n))
- Do a apt-get update before running package install [\#90](https://github.com/bflad/chef-stash/pull/90) ([linc01n](https://github.com/linc01n))
- Use proper setenv.sh format for v3.8+. [\#89](https://github.com/bflad/chef-stash/pull/89) ([patcon](https://github.com/patcon))
- Fix minor rubocop style errors [\#88](https://github.com/bflad/chef-stash/pull/88) ([patcon](https://github.com/patcon))
- Add support of Stash versions 3.8.1, 3.9.1, 3.9.2, 3.10.0 [\#87](https://github.com/bflad/chef-stash/pull/87) ([legal90](https://github.com/legal90))

## [3.15.0](https://github.com/bflad/chef-stash/tree/3.15.0) (2015-04-22)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.14.4...3.15.0)

**Merged pull requests:**

- Prepare for 3.15.0 cookbook release [\#83](https://github.com/bflad/chef-stash/pull/83) ([linc01n](https://github.com/linc01n))
- Upgrade stash to 3.8.0 and backup client to 1.8.2 [\#82](https://github.com/bflad/chef-stash/pull/82) ([linc01n](https://github.com/linc01n))
- Speedup travis build [\#81](https://github.com/bflad/chef-stash/pull/81) ([linc01n](https://github.com/linc01n))

## [3.14.4](https://github.com/bflad/chef-stash/tree/3.14.4) (2015-03-17)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.14.3...3.14.4)

**Fixed bugs:**

- service stash start|restart|stop|status not working on CentOS 7 [\#67](https://github.com/bflad/chef-stash/issues/67)

**Merged pull requests:**

- Prepare for 3.14.4 cookbook release [\#80](https://github.com/bflad/chef-stash/pull/80) ([linc01n](https://github.com/linc01n))
- Fix \#67 [\#79](https://github.com/bflad/chef-stash/pull/79) ([linc01n](https://github.com/linc01n))

## [3.14.3](https://github.com/bflad/chef-stash/tree/3.14.3) (2015-03-13)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.14.2...3.14.3)

**Merged pull requests:**

- Prepare for 3.14.3 cookbook release [\#78](https://github.com/bflad/chef-stash/pull/78) ([linc01n](https://github.com/linc01n))
- Upgrade Stash to 3.7.1 [\#77](https://github.com/bflad/chef-stash/pull/77) ([crivabene](https://github.com/crivabene))
- Fix ubuntu version [\#76](https://github.com/bflad/chef-stash/pull/76) ([linc01n](https://github.com/linc01n))
- Upgrade stash to 3.7.0 and backup client to 1.7.0 [\#75](https://github.com/bflad/chef-stash/pull/75) ([linc01n](https://github.com/linc01n))

## [3.14.2](https://github.com/bflad/chef-stash/tree/3.14.2) (2015-02-12)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.14.1...3.14.2)

**Merged pull requests:**

- Prepare 3.14.2 release [\#74](https://github.com/bflad/chef-stash/pull/74) ([linc01n](https://github.com/linc01n))
- Update stash to 3.6.1 [\#73](https://github.com/bflad/chef-stash/pull/73) ([linc01n](https://github.com/linc01n))

## [3.14.1](https://github.com/bflad/chef-stash/tree/3.14.1) (2015-02-11)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.14.0...3.14.1)

**Fixed bugs:**

- Missing mysql-chef\_gem cookbook [\#69](https://github.com/bflad/chef-stash/issues/69)

**Merged pull requests:**

- Prepare for 3.14.1 cookbook release [\#72](https://github.com/bflad/chef-stash/pull/72) ([linc01n](https://github.com/linc01n))
- Lock database cookbook to 2.3.1 [\#71](https://github.com/bflad/chef-stash/pull/71) ([linc01n](https://github.com/linc01n))
- Fix rubocop offenses [\#70](https://github.com/bflad/chef-stash/pull/70) ([linc01n](https://github.com/linc01n))
- Extend license year to 2015 [\#66](https://github.com/bflad/chef-stash/pull/66) ([linc01n](https://github.com/linc01n))
- Add contributors [\#65](https://github.com/bflad/chef-stash/pull/65) ([linc01n](https://github.com/linc01n))
- Bump dependencies in Gemfile [\#62](https://github.com/bflad/chef-stash/pull/62) ([bflad](https://github.com/bflad))
- Fixed deprecation warning from Berkshelf [\#61](https://github.com/bflad/chef-stash/pull/61) ([legal90](https://github.com/legal90))

## [3.14.0](https://github.com/bflad/chef-stash/tree/3.14.0) (2015-01-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.13.0...3.14.0)

**Fixed bugs:**

- cookbook is broker because of no versionlock in metadata [\#55](https://github.com/bflad/chef-stash/issues/55)

**Merged pull requests:**

- Prepare 3.14.0 release, begin documenting 4.0.0 changes [\#60](https://github.com/bflad/chef-stash/pull/60) ([bflad](https://github.com/bflad))
- Split metadata supports/depends, lock mysql ~\> 5.0, fixes \#55 [\#59](https://github.com/bflad/chef-stash/pull/59) ([bflad](https://github.com/bflad))
- Documentation surrounding properties versus now deprecated plugins [\#57](https://github.com/bflad/chef-stash/pull/57) ([bflad](https://github.com/bflad))
- the ability to set all property values instead of only the plugins [\#46](https://github.com/bflad/chef-stash/pull/46) ([ramonskie](https://github.com/ramonskie))

## [3.13.0](https://github.com/bflad/chef-stash/tree/3.13.0) (2015-01-23)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.12.1...3.13.0)

**Closed issues:**

- Support Stash 3.6.0 [\#47](https://github.com/bflad/chef-stash/issues/47)
- all http auth not working when using apache \(eg git clone\) [\#42](https://github.com/bflad/chef-stash/issues/42)
- 3.12.0 is not yet release to supermarket [\#40](https://github.com/bflad/chef-stash/issues/40)

**Merged pull requests:**

- Prepare for 3.13.0 cookbook release [\#54](https://github.com/bflad/chef-stash/pull/54) ([bflad](https://github.com/bflad))
- Rubocop fixes and ignores [\#53](https://github.com/bflad/chef-stash/pull/53) ([bflad](https://github.com/bflad))
- Default to Stash 3.6.0, Stash Backup Client 1.6.0, resolves \#47 [\#52](https://github.com/bflad/chef-stash/pull/52) ([bflad](https://github.com/bflad))
- Convert Test Kitchen and Vagrant to Atlas boxes [\#51](https://github.com/bflad/chef-stash/pull/51) ([bflad](https://github.com/bflad))
- Add Stash version default checksums for 3.1.7, 3.2.7, 3.3.3, 3.3.5, 3.4.1, 3.4.3, 3.4.5, 3.5.0, 3.5.1, and 3.6.0 [\#48](https://github.com/bflad/chef-stash/pull/48) ([bflad](https://github.com/bflad))
- Fixed HTTP authentication [\#45](https://github.com/bflad/chef-stash/pull/45) ([legal90](https://github.com/legal90))
- Fixes for the Stash library [\#44](https://github.com/bflad/chef-stash/pull/44) ([legal90](https://github.com/legal90))
- Fix for "sh: 'rsync' no such file or directory" on RHEL-like systems [\#43](https://github.com/bflad/chef-stash/pull/43) ([legal90](https://github.com/legal90))
- Upgrade Stash to 3.4.0 [\#41](https://github.com/bflad/chef-stash/pull/41) ([linc01n](https://github.com/linc01n))

## [3.12.1](https://github.com/bflad/chef-stash/tree/3.12.1) (2014-10-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.12.0...3.12.1)

## [3.12.0](https://github.com/bflad/chef-stash/tree/3.12.0) (2014-10-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.11.0...3.12.0)

**Merged pull requests:**

- Default to Stash 3.3.1 and git package for CentOS/RHEL 7 [\#39](https://github.com/bflad/chef-stash/pull/39) ([bflad](https://github.com/bflad))

## [3.11.0](https://github.com/bflad/chef-stash/tree/3.11.0) (2014-10-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.10.1...3.11.0)

**Closed issues:**

- stash 3.2 directories changed [\#35](https://github.com/bflad/chef-stash/issues/35)

**Merged pull requests:**

- Upgrade to Stash 3.3.0 [\#37](https://github.com/bflad/chef-stash/pull/37) ([linc01n](https://github.com/linc01n))
- Add unset of basic auth header in web app config [\#36](https://github.com/bflad/chef-stash/pull/36) ([ghost](https://github.com/ghost))

## [3.10.1](https://github.com/bflad/chef-stash/tree/3.10.1) (2014-07-10)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.10.0...3.10.1)

**Merged pull requests:**

- updated stash to 3.1.1 [\#33](https://github.com/bflad/chef-stash/pull/33) ([ramonskie](https://github.com/ramonskie))
- support apache 2.4 access control syntax [\#32](https://github.com/bflad/chef-stash/pull/32) ([andrewgoktepe](https://github.com/andrewgoktepe))

## [3.10.0](https://github.com/bflad/chef-stash/tree/3.10.0) (2014-06-26)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.9.1...3.10.0)

**Merged pull requests:**

- Update stash to 3.1.0 [\#31](https://github.com/bflad/chef-stash/pull/31) ([linc01n](https://github.com/linc01n))

## [3.9.1](https://github.com/bflad/chef-stash/tree/3.9.1) (2014-06-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.9.0...3.9.1)

**Merged pull requests:**

- Bump stash version [\#30](https://github.com/bflad/chef-stash/pull/30) ([linc01n](https://github.com/linc01n))

## [3.9.0](https://github.com/bflad/chef-stash/tree/3.9.0) (2014-05-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.8.3...3.9.0)

## [3.8.3](https://github.com/bflad/chef-stash/tree/3.8.3) (2014-05-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.8.2...3.8.3)

**Merged pull requests:**

- Update stash to 2.12.3 [\#29](https://github.com/bflad/chef-stash/pull/29) ([linc01n](https://github.com/linc01n))

## [3.8.2](https://github.com/bflad/chef-stash/tree/3.8.2) (2014-05-07)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.8.1...3.8.2)

**Merged pull requests:**

- Update stash to 2.12.2 [\#27](https://github.com/bflad/chef-stash/pull/27) ([linc01n](https://github.com/linc01n))

## [3.8.1](https://github.com/bflad/chef-stash/tree/3.8.1) (2014-04-22)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.8.0...3.8.1)

**Merged pull requests:**

- Update stash to 2.12.1 and backup to 1.2.1 [\#26](https://github.com/bflad/chef-stash/pull/26) ([linc01n](https://github.com/linc01n))

## [3.8.0](https://github.com/bflad/chef-stash/tree/3.8.0) (2014-03-26)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.7.0...3.8.0)

**Merged pull requests:**

- updated to version 2.11.4 [\#25](https://github.com/bflad/chef-stash/pull/25) ([ramonskie](https://github.com/ramonskie))

## [3.7.0](https://github.com/bflad/chef-stash/tree/3.7.0) (2014-02-28)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.6.0...3.7.0)

**Closed issues:**

- first-time setup with database does not work [\#16](https://github.com/bflad/chef-stash/issues/16)

**Merged pull requests:**

- Default Stash to 2.11.2  [\#23](https://github.com/bflad/chef-stash/pull/23) ([linc01n](https://github.com/linc01n))

## [3.6.0](https://github.com/bflad/chef-stash/tree/3.6.0) (2014-01-03)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.5.0...3.6.0)

**Merged pull requests:**

- removed the start action [\#21](https://github.com/bflad/chef-stash/pull/21) ([ramonskie](https://github.com/ramonskie))

## [3.5.0](https://github.com/bflad/chef-stash/tree/3.5.0) (2013-12-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.4.0...3.5.0)

## [3.4.0](https://github.com/bflad/chef-stash/tree/3.4.0) (2013-12-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.3.0...3.4.0)

**Merged pull requests:**

- Updates for Stash 2.9.4 [\#20](https://github.com/bflad/chef-stash/pull/20) ([xeon22](https://github.com/xeon22))

## [3.3.0](https://github.com/bflad/chef-stash/tree/3.3.0) (2013-11-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.2.0...3.3.0)

## [3.2.0](https://github.com/bflad/chef-stash/tree/3.2.0) (2013-11-18)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.1.2...3.2.0)

## [3.1.2](https://github.com/bflad/chef-stash/tree/3.1.2) (2013-11-18)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.1.1...3.1.2)

**Closed issues:**

- Random hibernate exceptions giving me the 500 page [\#19](https://github.com/bflad/chef-stash/issues/19)
- stash.tar.gz unzip fails [\#17](https://github.com/bflad/chef-stash/issues/17)
- Cannot find a resource matching java\_ark\[jdk\] [\#15](https://github.com/bflad/chef-stash/issues/15)

## [3.1.1](https://github.com/bflad/chef-stash/tree/3.1.1) (2013-11-04)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.1.0...3.1.1)

**Closed issues:**

- Apache2 Gets Installed Regardless [\#14](https://github.com/bflad/chef-stash/issues/14)
- Hash diff function broken [\#13](https://github.com/bflad/chef-stash/issues/13)

## [3.1.0](https://github.com/bflad/chef-stash/tree/3.1.0) (2013-11-03)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.0.1...3.1.0)

## [3.0.1](https://github.com/bflad/chef-stash/tree/3.0.1) (2013-10-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/3.0.0...3.0.1)

## [3.0.0](https://github.com/bflad/chef-stash/tree/3.0.0) (2013-10-12)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.21.0...3.0.0)

**Closed issues:**

- isn't it better to use ark for downloading stash? [\#9](https://github.com/bflad/chef-stash/issues/9)

## [2.21.0](https://github.com/bflad/chef-stash/tree/2.21.0) (2013-10-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.20.0...2.21.0)

**Merged pull requests:**

- - Added extra settings for plugin in the stash-config.properties file [\#12](https://github.com/bflad/chef-stash/pull/12) ([xeon22](https://github.com/xeon22))

## [2.20.0](https://github.com/bflad/chef-stash/tree/2.20.0) (2013-10-04)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.19.0...2.20.0)

**Merged pull requests:**

- - Added versions and checksums for latest versions [\#11](https://github.com/bflad/chef-stash/pull/11) ([xeon22](https://github.com/xeon22))

## [2.19.0](https://github.com/bflad/chef-stash/tree/2.19.0) (2013-08-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.18.0...2.19.0)

## [2.18.0](https://github.com/bflad/chef-stash/tree/2.18.0) (2013-08-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.17.0...2.18.0)

## [2.17.0](https://github.com/bflad/chef-stash/tree/2.17.0) (2013-08-12)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.16.0...2.17.0)

## [2.16.0](https://github.com/bflad/chef-stash/tree/2.16.0) (2013-08-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.15.0...2.16.0)

## [2.15.0](https://github.com/bflad/chef-stash/tree/2.15.0) (2013-07-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.14.0...2.15.0)

## [2.14.0](https://github.com/bflad/chef-stash/tree/2.14.0) (2013-06-18)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.13.0...2.14.0)

## [2.13.0](https://github.com/bflad/chef-stash/tree/2.13.0) (2013-05-30)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.12.0...2.13.0)

## [2.12.0](https://github.com/bflad/chef-stash/tree/2.12.0) (2013-05-10)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.11.0...2.12.0)

## [2.11.0](https://github.com/bflad/chef-stash/tree/2.11.0) (2013-05-07)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.10.1...2.11.0)

**Closed issues:**

- Add LWRP for stash hooks and repositories [\#4](https://github.com/bflad/chef-stash/issues/4)

## [2.10.1](https://github.com/bflad/chef-stash/tree/2.10.1) (2013-05-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.10.0...2.10.1)

## [2.10.0](https://github.com/bflad/chef-stash/tree/2.10.0) (2013-05-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.9.0...2.10.0)

**Merged pull requests:**

- Resolves Issue \#4 [\#5](https://github.com/bflad/chef-stash/pull/5) ([moserke](https://github.com/moserke))

## [2.9.0](https://github.com/bflad/chef-stash/tree/2.9.0) (2013-05-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.8.0...2.9.0)

## [2.8.0](https://github.com/bflad/chef-stash/tree/2.8.0) (2013-04-22)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.7.0...2.8.0)

## [2.7.0](https://github.com/bflad/chef-stash/tree/2.7.0) (2013-04-20)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.6.1...2.7.0)

## [2.6.1](https://github.com/bflad/chef-stash/tree/2.6.1) (2013-04-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.6.0...2.6.1)

## [2.6.0](https://github.com/bflad/chef-stash/tree/2.6.0) (2013-03-28)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.5.0...2.6.0)

## [2.5.0](https://github.com/bflad/chef-stash/tree/2.5.0) (2013-03-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.4.0...2.5.0)

## [2.4.0](https://github.com/bflad/chef-stash/tree/2.4.0) (2013-02-08)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.3.1...2.4.0)

## [2.3.1](https://github.com/bflad/chef-stash/tree/2.3.1) (2013-02-07)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.3.0...2.3.1)

## [2.3.0](https://github.com/bflad/chef-stash/tree/2.3.0) (2013-02-07)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.8...2.3.0)

## [2.1.8](https://github.com/bflad/chef-stash/tree/2.1.8) (2013-01-16)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.7...2.1.8)

## [2.1.7](https://github.com/bflad/chef-stash/tree/2.1.7) (2013-01-16)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.6...2.1.7)

## [2.1.6](https://github.com/bflad/chef-stash/tree/2.1.6) (2012-12-23)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.5...2.1.6)

## [2.1.5](https://github.com/bflad/chef-stash/tree/2.1.5) (2012-12-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.4...2.1.5)

## [2.1.4](https://github.com/bflad/chef-stash/tree/2.1.4) (2012-12-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.3...2.1.4)

## [2.1.3](https://github.com/bflad/chef-stash/tree/2.1.3) (2012-12-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.2...2.1.3)

## [2.1.2](https://github.com/bflad/chef-stash/tree/2.1.2) (2012-12-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.1...2.1.2)

## [2.1.1](https://github.com/bflad/chef-stash/tree/2.1.1) (2012-12-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.1.0...2.1.1)

## [2.1.0](https://github.com/bflad/chef-stash/tree/2.1.0) (2012-12-18)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.0.2...2.1.0)

## [2.0.2](https://github.com/bflad/chef-stash/tree/2.0.2) (2012-11-16)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.0.1...2.0.2)

## [2.0.1](https://github.com/bflad/chef-stash/tree/2.0.1) (2012-11-06)
[Full Changelog](https://github.com/bflad/chef-stash/compare/2.0.0...2.0.1)

## [2.0.0](https://github.com/bflad/chef-stash/tree/2.0.0) (2012-11-05)
[Full Changelog](https://github.com/bflad/chef-stash/compare/1.0.3...2.0.0)

**Closed issues:**

- Add Minitests [\#1](https://github.com/bflad/chef-stash/issues/1)

## [1.0.3](https://github.com/bflad/chef-stash/tree/1.0.3) (2012-11-02)
[Full Changelog](https://github.com/bflad/chef-stash/compare/1.0.2...1.0.3)

## [1.0.2](https://github.com/bflad/chef-stash/tree/1.0.2) (2012-11-02)
[Full Changelog](https://github.com/bflad/chef-stash/compare/1.0.1...1.0.2)

## [1.0.1](https://github.com/bflad/chef-stash/tree/1.0.1) (2012-10-26)
[Full Changelog](https://github.com/bflad/chef-stash/compare/1.0.0...1.0.1)

## [1.0.0](https://github.com/bflad/chef-stash/tree/1.0.0) (2012-10-11)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.16...1.0.0)

**Closed issues:**

- Upgrade recipe does not extract over installation [\#3](https://github.com/bflad/chef-stash/issues/3)

## [0.2.16](https://github.com/bflad/chef-stash/tree/0.2.16) (2012-09-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.15...0.2.16)

## [0.2.15](https://github.com/bflad/chef-stash/tree/0.2.15) (2012-09-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.14...0.2.15)

## [0.2.14](https://github.com/bflad/chef-stash/tree/0.2.14) (2012-09-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.13...0.2.14)

## [0.2.13](https://github.com/bflad/chef-stash/tree/0.2.13) (2012-09-24)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.12...0.2.13)

**Closed issues:**

- TravisCI Integration [\#2](https://github.com/bflad/chef-stash/issues/2)

## [0.2.12](https://github.com/bflad/chef-stash/tree/0.2.12) (2012-09-21)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.11...0.2.12)

## [0.2.11](https://github.com/bflad/chef-stash/tree/0.2.11) (2012-09-20)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.10...0.2.11)

## [0.2.10](https://github.com/bflad/chef-stash/tree/0.2.10) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.9...0.2.10)

## [0.2.9](https://github.com/bflad/chef-stash/tree/0.2.9) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.8...0.2.9)

## [0.2.8](https://github.com/bflad/chef-stash/tree/0.2.8) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.7...0.2.8)

## [0.2.7](https://github.com/bflad/chef-stash/tree/0.2.7) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.6...0.2.7)

## [0.2.6](https://github.com/bflad/chef-stash/tree/0.2.6) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.5...0.2.6)

## [0.2.5](https://github.com/bflad/chef-stash/tree/0.2.5) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.4...0.2.5)

## [0.2.4](https://github.com/bflad/chef-stash/tree/0.2.4) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.3...0.2.4)

## [0.2.3](https://github.com/bflad/chef-stash/tree/0.2.3) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.2...0.2.3)

## [0.2.2](https://github.com/bflad/chef-stash/tree/0.2.2) (2012-09-19)
[Full Changelog](https://github.com/bflad/chef-stash/compare/0.2.1...0.2.2)

## [0.2.1](https://github.com/bflad/chef-stash/tree/0.2.1) (2012-09-19)


\* *This Change Log was automatically generated by [github_changelog_generator](https://github.com/skywinder/Github-Changelog-Generator)*
