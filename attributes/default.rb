set['build_essential']['compiletime'] = true

default['stash']['home_path']    = '/var/atlassian/application-data/stash'
default['stash']['install_path'] = '/opt/atlassian'
default['stash']['install_type'] = 'standalone'
default['stash']['service_type'] = 'init'
default['stash']['url_base']     = 'http://www.atlassian.com/software/stash/downloads/binary/atlassian-stash'
default['stash']['user']         = 'stash'
default['stash']['version']      = '2.11.2'

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
when '2.9.0' then '5638c1af3008379d26fcb70dd392db5149a6b1b969ec5b9334647ba01c71c74b'
when '2.9.1' then 'fe57c0a483ecd967307080b157c7af42260c59e48a919784b346eb496c283386'
when '2.9.2' then 'd4c31a0523ab4df5d12a8dcd24778cfd9db343f668bee1f4a0b18381d173088c'
when '2.9.3' then '6d866a2081f0a69fdd29dc059836f1d3d1bb51453bc7cbc6c9518ebc3227a389'
when '2.9.4' then '3425e39eb5dbffe24cf44558eaca38d0884b8d07602c3225c9215007ae13bef3'
when '2.10.0' then '3a3995dadb05d6a86d7dcc21bc86ca63a713d194f5319297e70760dc833279e8'
when '2.10.1' then 'f26e738c3e8d58dd460fcc8fd626d1cca01572f98ec77d3624fba321a96ac74d'
when '2.11.2' then '873fbdfaee52af6f1899ffd216192edadc8bfc491a43915f8b7dd4a41d19ede6'
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
default['stash']['backup_client']['url_base']     = 'http://downloads.atlassian.com/software/stash/downloads/stash-backup-client'
default['stash']['backup_client']['user']         = 'admin'
default['stash']['backup_client']['version']      = '1.1.0'

default['stash']['backup_client']['url']      = "#{node['stash']['backup_client']['url_base']}-#{node['stash']['backup_client']['version']}.zip"
default['stash']['backup_client']['checksum'] =
case node['stash']['backup_client']['version']
when '1.0.0-beta-11' then 'b1ec42ef96db0cbb3f5678c75da119019d8894c3b09ee886ced075c694bbafb2'
when '1.0.0' then 'a3c063ac04c484d9a5d36de68a1162e9869f08c4703cc1241157738cf17dc92e'
when '1.0.3' then '7a557242e76612757d0b623afa9dc757c12f51a706216be88d3355195ec0ca97'
when '1.1.0' then 'd2276df535e0f8e909cd0c1c9700ca275be378145451f9d62a5980b62fdfab74'
end

default['stash']['backup_client']['cron']['day'] = '*'
default['stash']['backup_client']['cron']['hour'] = '0'
default['stash']['backup_client']['cron']['minute'] = '0'
default['stash']['backup_client']['cron']['month'] = '*'
default['stash']['backup_client']['cron']['weekday'] = '*'

default['stash']['database']['host']     = 'localhost'
default['stash']['database']['name']     = 'stash'
default['stash']['database']['password'] = 'changeit'
default['stash']['database']['port']     = 3306
default['stash']['database']['testInterval'] = 2
default['stash']['database']['type']     = 'mysql'
default['stash']['database']['user']     = 'stash'

default['stash']['jvm']['minimum_memory']  = '512m'
default['stash']['jvm']['maximum_memory']  = '768m'
default['stash']['jvm']['maximum_permgen'] = '256m'
default['stash']['jvm']['java_opts']       = ''
default['stash']['jvm']['support_args']    = ''

default['stash']['plugin'] = {}

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port']     = '7999'

default['stash']['tomcat']['keyAlias']     = 'tomcat'
default['stash']['tomcat']['keystoreFile'] = "#{node['stash']['home_path']}/.keystore"
default['stash']['tomcat']['keystorePass'] = 'changeit'
default['stash']['tomcat']['port']         = '7990'
default['stash']['tomcat']['ssl_port']     = '8443'
