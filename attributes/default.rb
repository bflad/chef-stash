set['build_essential']['compiletime'] = true

default['stash']['home_path']    = '/var/atlassian/application-data/stash'
default['stash']['install_path'] = '/opt/atlassian'
default['stash']['install_type'] = 'standalone'
default['stash']['service_type'] = 'init'
default['stash']['url_base']     = 'http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash'
default['stash']['user']         = 'stash'
default['stash']['version']      = '3.6.0'

default['stash']['url']      = "#{node['stash']['url_base']}-#{node['stash']['version']}.tar.gz"
default['stash']['checksum'] =
case node['stash']['version']
when '1.3.0' then '2731997d6e223cb512906183f5c231be602319ce05d2794cdf5b957a1fd06e08'
when '1.3.1' then '6e9e344fa9f4976afef862f27e1a0f4fae4adc6dad771f3ffbc2cedd5addb243'
when '2.0.0' then 'f943df5262c0cfdf03a087fab08649e83f437300e4f409ac7b542d4da53179fd'
when '2.0.1' then '73881542544f99d2602c065da535a8f437c4e3c6d9fde0e7d7cadd5dfa3defcb'
when '2.0.2' then '7b28ed244339cd8da237ba82b32a3c3eae8bb890ba5bb4190294ffcd04a88bd4'
when '2.0.3' then 'c57e5f3f63ea235180355f393b99db647d3e93112a73f40e8881b64e6b7fb6dd'
when '2.1.0' then '299ae786cdec495f22a0116c2a82bdf2151ecc53507a845568a62269db210205'
when '2.1.1' then 'be29bf0c2044466fa0cd60f2f597053967644d92ae354510c4262385d00ad8cd'
when '2.2.0' then '3e8a461f30dbb6bd31a0d9aa42d639a147a3da2b9c534e7923eccca4169bf052'
when '2.3.0' then '584bde276b4acb079e4c32266352f09fba3ed018ce3ec0984f2c6ebded9067db'
when '2.3.1' then '736580eac07e229b165f83600e2c783b5cd54b775be99aeb4a57dee6715ac626'
when '2.4.0' then 'f71fd89a5b0364179cd3d50476be8843291fe2629d2a379f6dcc8434ae724a97'
when '2.4.1' then '9b6347e25738b728cce33dce6eb7171be78fa913665b2065b0c9d1c3df4de9e0'
when '2.4.2' then 'f7152641addb87ad465ea5d1fa10412bdb095ac7229b8e2f033a2e4e5e0df40c'
when '2.5.0' then '75fdae77d0b671eb34737458b2cae6c150a2a487c8e21df4ce820179b04d11d9'
when '2.5.1' then '5e799d4f049d015eba5e3db8ccfc7dafc8ffd68eabecffd5a4d2430e118892d2'
when '2.5.2' then '6b499626d5ef91dc298c868374ed2afd09deec7b99fdb0cb629afe325b9c6ab7'
when '2.5.3' then '6eb43c7139e5011d4133f8bf773c29d58db459f09f4fdb44ded35dbd20848710'
when '2.6.0' then 'c44d89c2728fadc238b577c8d9719af6d4151dd7841a4b0f3335c946358b82b6'
when '2.6.1' then '17ba67a7675e045f89fc83751bcb48c80fa1409c870902e4962eccc288eca7e2'
when '2.6.2' then '65c56c887eaef4ba4b581894b78d5169e3ea247611083c9bf021927b1953cd30'
when '2.6.3' then '7dee2f3331803282379380721de1c6ea307cca210dd01afc1b3cd9630231e042'
when '2.6.4' then 'f561ee131977f96bf049ee0b889f4b5905b6ccc2faa36ac5a73c366e3aaaafca'
when '2.7.0' then 'e41d1d79ab94d3256c443b66c8536d526f9cba72ac5a190a7b19a83d006c18ee'
when '2.7.1' then '7487c0d7e03256eb3ab027ff744dd5e56b84508b01b17f39afaa1237305939f6'
when '2.7.2' then '9efbd97ff84b74e8fbbe97c97c55df2f4b896ef35d38ec79ad70084c141c570b'
when '2.8.0' then 'd7a0af075f0ee3d1290ddbd14ed11be2e4e83b3ebc6414f5655a39e2478af362'
when '2.8.1' then '4282f05f76fce2104e76c972a4d46092020e3e90894537e06c739df9c6680437'
when '2.8.2' then '5fe6fb8051a3cad63ca6c07a2d419bfbc6657bde88ada45cc2990815764d0ab7'
when '2.8.3' then '67d6c03f7da53b42ad1d86d07e41102882f34d52fd9c739716340afb8c094177'
when '2.8.4' then '82032a99e7e1558396c9db786760d7dff545543f47c2cc5d5c9455ae055edc27'
when '2.8.5' then '61db4e4871ad5ee612e214e9bb346836d7c3ca5ccea4ca73ec4b83dba4f3ac2b'
when '2.9.0' then '5638c1af3008379d26fcb70dd392db5149a6b1b969ec5b9334647ba01c71c74b'
when '2.9.1' then 'fe57c0a483ecd967307080b157c7af42260c59e48a919784b346eb496c283386'
when '2.9.2' then 'd4c31a0523ab4df5d12a8dcd24778cfd9db343f668bee1f4a0b18381d173088c'
when '2.9.3' then '6d866a2081f0a69fdd29dc059836f1d3d1bb51453bc7cbc6c9518ebc3227a389'
when '2.9.4' then '3425e39eb5dbffe24cf44558eaca38d0884b8d07602c3225c9215007ae13bef3'
when '2.9.5' then 'b6989f6633e700130dc2468ab2f19e1a383ca36daae0489ab09e6c7c0ca18a46'
when '2.10.0' then '3a3995dadb05d6a86d7dcc21bc86ca63a713d194f5319297e70760dc833279e8'
when '2.10.1' then 'f26e738c3e8d58dd460fcc8fd626d1cca01572f98ec77d3624fba321a96ac74d'
when '2.10.2' then '9ed03a0556ae5a71033706af05bc913de1a0ec0eed3236d78e32145b9bcc51d2'
when '2.10.3' then '4eb49ac7b23d51e6b9d306f7e3c731485586a6b6b86c12acd2f25c7e996c0471'
when '2.10.4' then 'def076b8ec4a817f23c87e288503c3d3d3d55a65bd77caef2769bfb9bdda96d2'
when '2.10.5' then 'a1d6f1ea39ed5eb16eecb235ceceee579970590ddfebd1bc6a1b98d62abe6993'
when '2.11.2' then '873fbdfaee52af6f1899ffd216192edadc8bfc491a43915f8b7dd4a41d19ede6'
when '2.11.3' then 'a6e0250ac6aed248320314e5755baee18a1f069d1035d36409793d8a6d3e96c4'
when '2.11.4' then '9c228f969dafd86cfbd980af86364894490f8c168827c7e4f630168e0ac417ea'
when '2.11.5' then '943f84547c375ca166a7563520aebe69be3b22f023b902b30d54ba8a20ae4302'
when '2.11.6' then 'd39c9689a773f898b658a3401ac64c1dc476777066c696dc83f9b569ec5191ed'
when '2.11.7' then '07113c2831843038799cf6597cb374022a47ae0a363ea424dde85d9f2ed98f04'
when '2.11.8' then '4c7336cdd60c776d26afc6689f309660e3528bdbfa702d9e938edbc27156c96c'
when '2.12.0' then '8284f664a19f264731b43dee06182858c57501154a77ea703c314a582f145bdc'
when '2.12.1' then 'c79943d3c1d2b6277cf7b2b0a240ea4aa84eb6d7c90797efcf09169d73b2e784'
when '2.12.2' then '039e4710a42a66c7b4d6bd11738c6fa31ef8e567ea8ff95ba2fe56d9fa5dc19e'
when '2.12.3' then '2e31777487a5a2c857b8a4b8c93ab8f6683af7ec8c9ec9a2e75af2e155b6683b'
when '2.12.4' then 'fc9c50f9aee43b677fe61921823137525675d66962583c53e4384400abee2a61'
when '3.0.1' then '53312a7d26e68b50eb778b8847e04162074b645c2d4014bc404eba59ff90f624'
when '3.0.4' then '2dc4db2a0fd306bad39d46b9e6a58d7c9d82c73711e002a93103f19e8133aa6a'
when '3.0.5' then 'f06b4d545d0e7acae6255f3f4d8c9a02bbdfebf16da793eaef8e1b8eef9303b2'
when '3.0.6' then '2b5cc70cba6e63aecd7591f02a1ed290825bf3916ffd867cc78b0fabb5badb48'
when '3.0.7' then 'f6f324fe70800235ba165ceaff15e1ff06d25c335d18821bb0c20c46145f055d'
when '3.0.8' then '501a02a3e9aa94eef161271cf478003c95fbee61c3ea609b72234970c09026d0'
when '3.1.0' then '9eb7ba9eec7b67cf14a3ae450c8ec3d8e9289a120672825ec8ba6a290b48c6a6'
when '3.1.1' then '14710e220ca4258cd81c0bd205e5df668abd7b0ed56be9fd6e74e82a394f53b9'
when '3.1.3' then 'b203d8d58bf95414077cac948066f5c84d600db258bb6168cc482b948f63529e'
when '3.1.4' then '378430ae2a6b0efdb808c28e7b009d55de88c4319cea0096fed03f38991dfae5'
when '3.1.5' then '78d7e4aa92f419b5babc937a1d21c6983c3eabc4c95294bf0f7fbc678757c153'
when '3.1.7' then '074a3b1a8340926030f7aeab3ebbba88cab796c817f4d26ee407b7373e17f8bc'
when '3.2.0' then '4e8c38b9450e718020d6f74df891987abe491529c66b3df19eff9a325856417e'
when '3.2.2' then 'a4e4b299c08432d4852872d6f8b754636ae640d434e5d1544637a54e5f1a3d39'
when '3.2.4' then 'd52b1b8ca50351bf9056d11bf584d6ca1e3ca70eddd936cb799543b487a6ba01'
when '3.2.5' then '1b1a5074643a26369110a41b634b50194900715253b193ac79742a23f8081ff4'
when '3.2.7' then '8a10ab462ef56a57e23ae8e1cb6f127e3ac6fb813f7d1f661f5843d933c41b0d'
when '3.3.0' then '4cb441824c08f28550d5ee2f883016461a356f626e5f38c0a29d345f174d34fd'
when '3.3.1' then 'cea015548d80ec10aaf405432de46bb5acade17ea024ce270fa2a4afd6e52cf9'
when '3.3.2' then '08251e15d91374de5da46f9739a1747312dead1509a72268d49abca21607bbe9'
when '3.3.3' then 'a048aa1e43098c4cef1e8bc8d39ea1049c6cd8296a38db7e91f4ac958d92bc2b'
when '3.3.5' then '36a3d20b906744d88b1ca4e87172bb2a343aa284c3b60c0c37c4d1cb983ec110'
when '3.4.0' then '31f9e1e9e66a03b566116fd4de0e0ba6d0a46883aaeee756fcd247c23b6774b8'
when '3.4.1' then 'e3279c40551d39f9998c743482a970e45c370f5d3e97d1f64bfe4414b8fef1be'
when '3.4.3' then '67b111d85e00665fc12f02f2fe7a6ffc016352ab4b51b8fb32f16449122e0d34'
when '3.4.5' then 'f81a4702b8a3dd729ce82abbb6f950a588803ff8bd5c64eb08f9057916c9d09e'
when '3.5.0' then '18138cab8884c9da0458d0668c9480dee05a962cbd8093bc196a39aa12e7250c'
when '3.5.1' then '0afcf5cb9dedf0a91864c47067cdbcd2bfcbe5d0c1d3cd187d05c658a6b4af9f'
when '3.6.0' then 'e047b2f9a8438a1be066080ea5210177b891fc952b776b5509e555427e0cbe91'
end

default['stash']['apache2']['access_log']         = ''
default['stash']['apache2']['error_log']          = ''
default['stash']['apache2']['port']               = 80
default['stash']['apache2']['virtual_host_alias'] = node['fqdn']
default['stash']['apache2']['virtual_host_name']  = node['hostname']

default['stash']['apache2']['ssl']['access_log']       = ''
default['stash']['apache2']['ssl']['chain_file']       = ''
default['stash']['apache2']['ssl']['error_log']        = ''
default['stash']['apache2']['ssl']['port']             = 443

case node['platform_family']
when 'rhel'
  default['stash']['apache2']['ssl']['certificate_file'] = '/etc/pki/tls/certs/localhost.crt'
  default['stash']['apache2']['ssl']['key_file']         = '/etc/pki/tls/private/localhost.key'
else
  default['stash']['apache2']['ssl']['certificate_file'] = '/etc/ssl/certs/ssl-cert-snakeoil.pem'
  default['stash']['apache2']['ssl']['key_file']         = '/etc/ssl/private/ssl-cert-snakeoil.key'
end

default['stash']['backup_client']['backup_path']  = '/tmp'
default['stash']['backup_client']['baseurl']      = "https://#{node['fqdn']}/"
default['stash']['backup_client']['install_path'] = node['stash']['install_path']
default['stash']['backup_client']['password']     = 'changeit'
default['stash']['backup_client']['user']         = 'admin'
default['stash']['backup_client']['version']      = '1.6.0'
stash_backup_client_version = Chef::Version.new(node['stash']['backup_client']['version'])

default['stash']['backup_client']['url_base']     =
if stash_backup_client_version <= Chef::Version.new('1.2.1')
  'http://downloads.atlassian.com/software/stash/downloads/stash-backup-client'
else
  'https://maven.atlassian.com/public/com/atlassian/stash/backup/stash-backup-distribution/'
end

default['stash']['backup_client']['url']      =
if stash_backup_client_version <= Chef::Version.new('1.2.1')
  "#{node['stash']['backup_client']['url_base']}-#{node['stash']['backup_client']['version']}.zip"
else
  "#{node['stash']['backup_client']['url_base']}/#{node['stash']['backup_client']['version']}/stash-backup-distribution-#{node['stash']['backup_client']['version']}.zip"
end

default['stash']['backup_client']['checksum'] =
case node['stash']['backup_client']['version']
when '1.0.0-beta-11' then 'b1ec42ef96db0cbb3f5678c75da119019d8894c3b09ee886ced075c694bbafb2'
when '1.0.0' then 'a3c063ac04c484d9a5d36de68a1162e9869f08c4703cc1241157738cf17dc92e'
when '1.0.3' then '7a557242e76612757d0b623afa9dc757c12f51a706216be88d3355195ec0ca97'
when '1.1.0' then 'd2276df535e0f8e909cd0c1c9700ca275be378145451f9d62a5980b62fdfab74'
when '1.2.0' then '5dee33dfdf78605caa0bee33caf5cff633613604ec3a30e93dead81c4401f9b9'
when '1.2.1' then 'eb680d58838b6218cbcb32f4bbf8e9be46adf1df43801e5e83e420ae58bc0d07'
when '1.3.0' then 'b9674f3235d4937d39186417594efdb3213b564d783aa09618a8086cc57f5170'
when '1.3.1' then '625af0a8402e85d62768f99a409ce4e140ef3afc961514b549fb9f98877c39db'
when '1.4.0' then 'c57a5fafb8aaaccea0bd57aae0bce24472ee6d172c0a558c11759b26b6c0196c'
when '1.5.0' then '6f7180a507a0e4c147e2c6a1fa82daf273e038243acefaa39fa7363472164765'
when '1.6.0' then '6605a8fbeab3f60567832f2bdba790583646b7ba637eee5b1da8148b5ecacf97'
end

default['stash']['backup_client']['cron']['day'] = '*'
default['stash']['backup_client']['cron']['hour'] = '0'
default['stash']['backup_client']['cron']['minute'] = '0'
default['stash']['backup_client']['cron']['month'] = '*'
default['stash']['backup_client']['cron']['weekday'] = '*'

default['stash']['database']['host']     = 'localhost'
default['stash']['database']['name']     = 'stash'
default['stash']['database']['password'] = 'changeit'
default['stash']['database']['testInterval'] = 2
default['stash']['database']['type']     = 'mysql'
default['stash']['database']['user']     = 'stash'

default['stash']['jvm']['minimum_memory']  = '512m'
default['stash']['jvm']['maximum_memory']  = '768m'
default['stash']['jvm']['maximum_permgen'] = '256m'
default['stash']['jvm']['java_opts']       = ''
default['stash']['jvm']['support_args']    = ''

default['stash']['plugin'] = {}
default['stash']['properties'] = {}

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port']     = '7999'

default['stash']['tomcat']['keyAlias']     = 'tomcat'
default['stash']['tomcat']['keystoreFile'] = "#{node['stash']['home_path']}/.keystore"
default['stash']['tomcat']['keystorePass'] = 'changeit'
default['stash']['tomcat']['port']         = '7990'
default['stash']['tomcat']['ssl_port']     = '8443'
