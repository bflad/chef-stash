# frozen_string_literal: true
set['build-essential']['compile_time'] = true

default['stash']['version']      = '4.6.2'
default['stash']['product']      = Chef::Version.new(node['stash']['version']) >= Chef::Version.new('4.0.0') ? 'bitbucket' : 'stash'

default['stash']['home_path'] = if Dir.exist?('/var/atlassian/application-data/stash')
                                  '/var/atlassian/application-data/stash'
                                else
                                  "/var/atlassian/application-data/#{node['stash']['product']}"
                                end

default['stash']['install_path'] = '/opt/atlassian'
default['stash']['install_type'] = 'standalone'
default['stash']['service_type'] = 'init'
default['stash']['url_base']     = "http://www.atlassian.com/software/stash/downloads/binary/atlassian-#{node['stash']['product']}"
default['stash']['user']         = node['stash']['product']

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
  when '2.1.2' then '8a44212ac221083b26a5e2917fb479d8756249805d7728e1462bffebf7988b0e'
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
  when '2.5.4' then 'aa95696775129ce1cffc7719c07e5d1b014e5b15885c44ded946772db197296c'
  when '2.6.0' then 'c44d89c2728fadc238b577c8d9719af6d4151dd7841a4b0f3335c946358b82b6'
  when '2.6.1' then '17ba67a7675e045f89fc83751bcb48c80fa1409c870902e4962eccc288eca7e2'
  when '2.6.2' then '65c56c887eaef4ba4b581894b78d5169e3ea247611083c9bf021927b1953cd30'
  when '2.6.3' then '7dee2f3331803282379380721de1c6ea307cca210dd01afc1b3cd9630231e042'
  when '2.6.4' then 'f561ee131977f96bf049ee0b889f4b5905b6ccc2faa36ac5a73c366e3aaaafca'
  when '2.6.5' then 'd1fd3b89fefb5bc62b7e4853192670b03e5823bfa205961f0795cb650bcfa1c6'
  when '2.7.0' then 'e41d1d79ab94d3256c443b66c8536d526f9cba72ac5a190a7b19a83d006c18ee'
  when '2.7.1' then '7487c0d7e03256eb3ab027ff744dd5e56b84508b01b17f39afaa1237305939f6'
  when '2.7.2' then '9efbd97ff84b74e8fbbe97c97c55df2f4b896ef35d38ec79ad70084c141c570b'
  when '2.7.6' then 'f1bb1bafacedcb6ed8152a44b02fcecbd04e4af3bff4471eb86ffe6a737978fd'
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
  when '2.11.9' then '06f2985c2555d0cf9a4d735d2460aa6ccd3dd3a687b818deca94882e3450e778'
  when '2.12.0' then '8284f664a19f264731b43dee06182858c57501154a77ea703c314a582f145bdc'
  when '2.12.1' then 'c79943d3c1d2b6277cf7b2b0a240ea4aa84eb6d7c90797efcf09169d73b2e784'
  when '2.12.2' then '039e4710a42a66c7b4d6bd11738c6fa31ef8e567ea8ff95ba2fe56d9fa5dc19e'
  when '2.12.3' then '2e31777487a5a2c857b8a4b8c93ab8f6683af7ec8c9ec9a2e75af2e155b6683b'
  when '2.12.4' then 'fc9c50f9aee43b677fe61921823137525675d66962583c53e4384400abee2a61'
  when '2.12.5' then 'bbe877e8883e656d911c31896b3ced6974ece3ebcf693b9912b4a80c52cb228f'
  when '2.12.6' then '31cede3c0210a454f9ff267685c27911aa5fc356ab977c741d851be9923fdb71'
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
  when '3.6.1' then '0b53ae801738fd0fe043dcf5206da1e057895d3dc7712d0bd74c51d0e043e379'
  when '3.7.0' then '6e58a82c79478b8fcb16447b17c352faccb76704759d0dd29f5835ccfef88f05'
  when '3.7.1' then 'a217e71fed08113fadf8402f5bd9a0ce3257042bc2cbeb35af8276fff31498ac'
  when '3.7.2' then '604982b3fa6e058b17545ef9da8bfa7ec8ecb1aabee25d1ff27dabb43bfd12cc'
  when '3.7.3' then '5707e52e7668188756d42a987c5742458bdbc135abfaa4ef46d3693291378f95'
  when '3.7.4' then '2b5bdb3235c2f9144adc76b6a38e7f2a96fc6222bd73c7329cc3c713e3d9b834'
  when '3.8.0' then '5512d68e18a85610e65ee1ad7e8df635bdd3cf299494636ede9694c3d41187b4'
  when '3.8.1' then 'c998165b7a95bca83d2f043a3e99aa4594b10f1cfe99a83bd4311421c5de5063'
  when '3.9.1' then 'c7f5e4976953957c06fe03aef20d497e395c29d19bfe2c3478b0c38cf8b14299'
  when '3.9.2' then '6ff2b5092453cb0beac1dcde16c0440bb1ee058ffe23e7d9fdf3ac815cf9280a'
  when '3.10.0' then 'ab7fecb10e6650fb5b94a20b22463771d7ab0f69a0971272d1a066dd2430f048'
  when '3.10.2' then '2597e9954397af5016c30c9f90befd09c6da71c4e7745813c77e60329427989e'
  when '3.10.3' then 'a06235ab33646d8588573a81f05345eab1cc4c107080153b7e9ab413da3ae4da'
  when '3.10.4' then '7a8ad1fa2a1d340c85f8d938a7b367fe3d93bd806d475aa7ff8ea88366e3221b'
  when '3.11.0' then '39cdc0b62c28d432a2b04d684dac297c7d3b0714ccb84d86e98773e68f314b18'
  when '3.11.1' then '7db6327554e3481a8b351188991f5858d01aeebce3f9bc290da5ad9d0fbfe1e7'
  when '3.11.2' then 'd071980bf8508cf2e3b92d2ce72d695cbbe37d94bfb94b8ed725e7c7c452090f'
  when '3.11.3' then '8da5704cdee1c75aece718322c8365bf1f34ccdfd82becba7b38246ce56bc9a6'
  when '3.11.4' then 'ec2e2ec8cfdcd5f79d90146548d26ea969d4e035a4db21bc30371fb48c910c75'
  when '3.11.6' then 'ad5a16eee58a0e171878fd8649e58b12b3f45126b5663ef9f508d29a6b3b3384'
  when '4.0.1' then 'f59462077fa4ccc522b7bbf1ad6ebef4753cd0e41abf54bc0491d07eea40593d'
  when '4.0.2' then '40dbb55194f9227d931a411c0785e73d38506070f9063d69e19201eb3e0ad2de'
  when '4.0.3' then '458addf0648186c90f7ffb026eb9464182e03c44a03c5658fe0cb44d2495df09'
  when '4.0.4' then 'd56ce5db0829b2a013c648c1fb354021166e3babeb84a449a988a42f6fbbe830'
  when '4.0.6' then '8e9aa2f08da294d1b4ed607a9ccc5df5617f1228482dc09113caedc6f1a83f59'
  when '4.0.7' then 'e6c09cec093483f1a789536c4b95f0b88bcd63afddf44b419c8447aca475d1da'
  when '4.0.8' then '8b1f2bde0f61091f6517131eb63fd1484b9cd2f60f77978f4078c198622321e5'
  when '4.1.0' then '0b1e41ab64c25d446d1cda54392abb9120c4b92413c1d79f6642869cbdcd5a46'
  when '4.1.3' then '2cdbab5394a3d82a854f33806d12b40f909ad172ef95064e9f0fce786fc65307'
  when '4.1.4' then '72cdb8edabccc85e782b556ade584df08cca4e49bc8493f14c05a590f56de5e7'
  when '4.1.5' then '2aec5ee2860adc5e8764d3c5912c2c324fcf948f890260cf88ecaa153b3b713a'
  when '4.1.6' then '6097a4a3a004dad905f1c5f85bf3fe344b20b09ddaca425bb5aedd472c999776'
  when '4.2.0' then '0632382b092105bbc99e580ef1a92e076eed94ac277ad4804e474bf70fa6722c'
  when '4.2.1' then 'a76098de1a205d9f26be3af568b28aed907f7be0dd7434affb0fb6a1347df20e'
  when '4.2.2' then '5ae639699fd9a7310de27ccf53284b49c83c4d9f8de78c425172b494c768eaaa'
  when '4.2.3' then '8d606f2f97f98ee53920e72c16ad716cf32c67b66b44ab88f334b4b300ec9708'
  when '4.3.0' then 'e07fa072b4c3010c62f334ba69927ba698a7bf7631a6fbd934da09ea1428adb8'
  when '4.3.1' then 'ca7d3ff8b356240de475891ad47671763de709063759ef99fc9ebff03ed36bc4'
  when '4.3.2' then '7d29f1dc5960547528856d54a2d498be5e3220d741a8500e6160f08bc4dec2b3'
  when '4.3.3' then '565442dcd850cb5295a2abd37cac4f379ffec5d49f702eda62a8f509159853e1'
  when '4.4.0' then 'ef7993ce088659dfeff974fdadcc3ff891451905e1cf0fac6de0a5979aaa76b7'
  when '4.4.1' then '91866f21cf13a9eb9f490b85b7e878d5283038f4824c66e97bdd92867c363c22'
  when '4.4.2' then '050e31d88da4cfd6715834fc5a48ec8977f461f0fac7899c602a75e251952be4'
  when '4.5.1' then 'eb93ede7c4bcaded79540f555062d9f1e79ab0da1615feca1e679cd7094eecd5'
  when '4.5.2' then 'cb3ee49ec20cd2f496dfbf0b8542a24c8db720226e3d80510b9fb4921968f89d'
  when '4.6.0' then '7dd309b5d17be41e3e2406276e14436136f9fd810655ceed6e08a72556e644aa'
  when '4.6.2' then 'a6260a139d794518ee0b7825f352144243f6da0a89f905cb8203c39516c63067'
  end

# Data bag where credentials and other sensitive data could be stored (optional)
default['stash']['data_bag_name'] = 'stash'
default['stash']['data_bag_item'] = 'stash'

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

default['stash']['backup']['strategy'] = 'backup_client'

default['stash']['backup']['backup_path'] = '/tmp'
default['stash']['backup']['baseurl']     = "https://#{node['fqdn']}/"
default['stash']['backup']['password']    = 'changeit'
default['stash']['backup']['user']        = 'admin'

default['stash']['backup']['cron']['enable'] = false
default['stash']['backup']['cron']['day'] = '*'
default['stash']['backup']['cron']['hour'] = '0'
default['stash']['backup']['cron']['minute'] = '0'
default['stash']['backup']['cron']['month'] = '*'
default['stash']['backup']['cron']['weekday'] = '*'

default['stash']['backup_client']['install_path'] = node['stash']['install_path']
default['stash']['backup_client']['version']      = '3.2.0'
stash_backup_client_version = Chef::Version.new(node['stash']['backup_client']['version'])

default['stash']['backup_client']['url_base'] =
  if stash_backup_client_version <= Chef::Version.new('1.2.1')
    'http://downloads.atlassian.com/software/stash/downloads/stash-backup-client'
  elsif stash_backup_client_version < Chef::Version.new('2.0.0')
    'https://maven.atlassian.com/public/com/atlassian/stash/backup/stash-backup-distribution/'
  else
    'https://maven.atlassian.com/repository/public/com/atlassian/bitbucket/server/backup/bitbucket-backup-distribution/'
  end

default['stash']['backup_client']['url'] =
  if stash_backup_client_version <= Chef::Version.new('1.2.1')
    "#{node['stash']['backup_client']['url_base']}-#{node['stash']['backup_client']['version']}.zip"
  elsif stash_backup_client_version < Chef::Version.new('2.0.0')
    "#{node['stash']['backup_client']['url_base']}/#{node['stash']['backup_client']['version']}/stash-backup-distribution-#{node['stash']['backup_client']['version']}.zip"
  else
    "#{node['stash']['backup_client']['url_base']}/#{node['stash']['backup_client']['version']}/bitbucket-backup-distribution-#{node['stash']['backup_client']['version']}.zip"
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
  when '1.7.0' then '5f2c14e58c98ba90b0de5e6083b6d1892802f2d68b845b594e62d691bf386d0c'
  when '1.8.0' then '0997e056a5befeed5f85b1e4cbe72115d7bd20f2ba30e7b7a105bcc1d3912e76'
  when '1.8.2' then 'ff41c353f73fe90cb0e67860cff7b021833e23df6c49232d1b102a0eae575127'
  when '1.9.0' then '620776f107a9c10f57f59e52be795621f0f0b8277805e28fff7dc664bbb48fb3'
  when '1.9.1' then '3cdad3393611d2c8d151c7d265ebd04764cbaba4a4d745a8b534dd9b8cf77d7b'
  when '2.0.0' then '2d9113ef6e173a65587b373ecc247b58ea8fab5ea826541b1d309ad0402a67be'
  when '2.0.1' then '0568b27367a367aebc45cade27bcca693b034a0b18dfd82789c0a6767324b19d'
  when '2.0.2' then 'c008bfdac59b45d8ce98ec0625e69316b3a5c51ccefa18363322df687d2c78c4'
  when '3.0.0' then '1a4dcea8fa5df919b9c92341b1a3b92aed5892022e0f94733540d1ebb88653df'
  when '3.1.0' then '7d586c65f6f0173c064e5d6508c380192c4a9ac3fc2314fbc3fce2e8f6b10daf'
  when '3.2.0' then 'e306e5d0b1f7bc36124ef2877df608b9c1fa2fb7e88d5252fc7dba680962b882'
  end

default['stash']['backup_diy']['install_path'] = "#{node['stash']['install_path']}/stash-diy-backup"
default['stash']['backup_diy']['repo_url'] = 'https://bitbucket.org/atlassianlabs/atlassian-stash-diy-backup.git'
default['stash']['backup_diy']['revision'] = 'master'

default['stash']['backup_diy']['backup_home_type'] = 'rsync'
default['stash']['backup_diy']['backup_archive_type'] = 'tar'
default['stash']['backup_diy']['exclude_repos'] = []
default['stash']['backup_diy']['gpg_recipient'] = ''
default['stash']['backup_diy']['temp_path'] = '/tmp/stash-backup-temp'
default['stash']['backup_diy']['verbose'] = true

default['stash']['backup_diy']['hipchat_url'] = 'https://api.hipchat.com'
default['stash']['backup_diy']['hipchat_room'] = ''
default['stash']['backup_diy']['hipchat_token'] = ''

default['stash']['database']['type']     = 'postgresql'
# When not set, the defaults from postgresql cookbook are used.
# See: https://github.com/hw-cookbooks/postgresql/blob/v3.4.24/attributes/default.rb#L71-L228
default['stash']['database']['version']  = nil

default['stash']['database']['host']     = '127.0.0.1'
default['stash']['database']['name']     = node['stash']['product']
default['stash']['database']['password'] = 'changeit'
default['stash']['database']['testInterval'] = 2
default['stash']['database']['user']     = node['stash']['product']

# See `libraries/stash.rb` for code to set actual default port
default['stash']['database']['port']     = nil

default['stash']['jvm']['minimum_memory']  = '512m'
default['stash']['jvm']['maximum_memory']  = '768m'
default['stash']['jvm']['maximum_permgen'] = '384m'
default['stash']['jvm']['java_opts']       = ''
default['stash']['jvm']['support_args']    = ''

default['stash']['plugin'] = {}
default['stash']['properties'] = {}

default['stash']['ssh']['hostname'] = node['fqdn']
default['stash']['ssh']['port']     = '7999'

default['stash']['tomcat']['port'] = '7990'
