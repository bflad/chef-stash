# frozen_string_literal: true

# Cookbook module
module Stash
  # Helper module
  module Helper
    REST_BASE = 'rest/api/1.0'

    def stash_uri(host, rest_endpoint)
      URI.parse(stash_url(host, rest_endpoint))
    end

    def stash_url(host, rest_endpoint)
      "https://#{host}/#{REST_BASE}/#{rest_endpoint}"
    end

    def stash_base64_creds(user)
      vault = ChefVault.new('passwords')
      user_vault = vault.user(user)
      Base64.encode64("#{user}:#{user_vault.decrypt_password}").strip!
    end

    def stash_put(uri, user, json = nil, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Put.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"
      request.content_type = 'application/json'
      request.body = json if json

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_post(uri, user, json = nil, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"
      request.content_type = 'application/json'
      request.body = json if json

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_get(uri, user, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_delete(uri, user, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Delete.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def check_for_errors(http_response, success_codes)
      return if success_codes.include?(http_response.code)
      Chef::Log.debug("http response code: #{http_response.code}")
      Chef::Log.debug("http response body: #{http_response.read_body}")
      Chef::Application.fatal!('error making stash request')
    end

    def install_chef_vault(source = 'http://rubygems.org', version = '1.2.0')
      gem_installer = Chef::Resource::ChefGem.new('chef-vault', run_context)
      gem_installer.version version
      gem_installer.options "--clear-sources --source #{source}"
      gem_installer.action :install
      gem_installer.after_created

      require 'chef-vault'
    end

    def stash_artifact_url
      return node['stash']['url'] unless node['stash']['url'].nil?
      "#{node['stash']['url_base']}-#{node['stash']['version']}.tar.gz"
    end

    def stash_artifact_checksum
      return node['stash']['checksum'] unless node['stash']['checksum'].nil?

      case node['stash']['version']
      when '1.3.1' then '6e9e344fa9f4976afef862f27e1a0f4fae4adc6dad771f3ffbc2cedd5addb243'
      when '2.0.3' then 'c57e5f3f63ea235180355f393b99db647d3e93112a73f40e8881b64e6b7fb6dd'
      when '2.1.2' then '8a44212ac221083b26a5e2917fb479d8756249805d7728e1462bffebf7988b0e'
      when '2.2.0' then '3e8a461f30dbb6bd31a0d9aa42d639a147a3da2b9c534e7923eccca4169bf052'
      when '2.3.1' then '736580eac07e229b165f83600e2c783b5cd54b775be99aeb4a57dee6715ac626'
      when '2.4.2' then 'f7152641addb87ad465ea5d1fa10412bdb095ac7229b8e2f033a2e4e5e0df40c'
      when '2.5.4' then 'aa95696775129ce1cffc7719c07e5d1b014e5b15885c44ded946772db197296c'
      when '2.6.5' then 'd1fd3b89fefb5bc62b7e4853192670b03e5823bfa205961f0795cb650bcfa1c6'
      when '2.7.6' then 'f1bb1bafacedcb6ed8152a44b02fcecbd04e4af3bff4471eb86ffe6a737978fd'
      when '2.8.4' then '82032a99e7e1558396c9db786760d7dff545543f47c2cc5d5c9455ae055edc27'
      when '2.8.5' then '61db4e4871ad5ee612e214e9bb346836d7c3ca5ccea4ca73ec4b83dba4f3ac2b'
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
      when '2.11.3' then 'a6e0250ac6aed248320314e5755baee18a1f069d1035d36409793d8a6d3e96c4'
      when '2.11.4' then '9c228f969dafd86cfbd980af86364894490f8c168827c7e4f630168e0ac417ea'
      when '2.11.5' then '943f84547c375ca166a7563520aebe69be3b22f023b902b30d54ba8a20ae4302'
      when '2.11.6' then 'd39c9689a773f898b658a3401ac64c1dc476777066c696dc83f9b569ec5191ed'
      when '2.11.7' then '07113c2831843038799cf6597cb374022a47ae0a363ea424dde85d9f2ed98f04'
      when '2.11.8' then '4c7336cdd60c776d26afc6689f309660e3528bdbfa702d9e938edbc27156c96c'
      when '2.11.9' then '06f2985c2555d0cf9a4d735d2460aa6ccd3dd3a687b818deca94882e3450e778'
      when '2.12.0' then '8284f664a19f264731b43dee06182858c57501154a77ea703c314a582f145bdc'
      when '2.12.1' then 'e092e333a7522690166999bd4bef9e837d8fc43f082c849413de0ca8b25a0701'
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
      when '4.4.4' then '48020ce1cf2b90fd6fa7e2c1568a9514cc9c2995413d8f95aea0cc0edb80880d'
      when '4.5.1' then 'eb93ede7c4bcaded79540f555062d9f1e79ab0da1615feca1e679cd7094eecd5'
      when '4.5.2' then 'cb3ee49ec20cd2f496dfbf0b8542a24c8db720226e3d80510b9fb4921968f89d'
      when '4.5.3' then '9995c7028e5f837c59c5533f9cf10f26bf8cb18f21c530e5aac59dc441a0c188'
      when '4.6.0' then '7dd309b5d17be41e3e2406276e14436136f9fd810655ceed6e08a72556e644aa'
      when '4.6.1' then 'c2c9207761152c29a7a3e032737cc51dcf4f8dd84491eb8f5665a8bffa78e938'
      when '4.6.2' then 'a6260a139d794518ee0b7825f352144243f6da0a89f905cb8203c39516c63067'
      when '4.6.3' then 'ddb4ab0201c0de891070fadef86a0169b1f21be90d61a2bae4e6b3e5a824adda'
      when '4.6.4' then '79e1f127c6aa5f76afdaddc46f75d6748c245e34dcbd66780577f3b5d6dd1af8'
      when '4.7.1' then 'cdbd5e82263638958468917bf9a3376591a8ccc500fd649e0c3e4c048de9ac9c'
      when '4.7.2' then 'bff0bb860ba4f7d73b0cbd0120efacec7899c935a38c6e45deb0f52f799ee8eb'
      when '4.8.0' then '6691554ca29efcad98391d33b8b9f7277e3335d45f12517bfd3cb2b9fd7f88e2'
      when '4.8.1' then 'd77de9aa4f19114f118f2438b05dbd81191847d524b974feecd030937385b275'
      when '4.8.2' then '14962bdd1713f4f1ccd580158ae206249d5e4c3cf4596275b2c258edc18b20ac'
      when '4.8.3' then '8f5544e8b9e6cb444df6ce401425ec308c380e317618c40d8895f6ebb2aa6328'
      when '4.8.4' then '11d0af3cbfd52912c16e6407c00f76e15920704260fb1367b4a65fc8fd0bb5b4'
      when '4.8.5' then '0f485702aef5b4ff9c366d3fb236591d37b823f2504aaf3618bd3f04b6195b44'
      when '4.8.6' then 'd43592fe60c6e0604e9871fd58469ff90723d03d79efd2cdd8cf90677ca722d0'
      when '4.9.0' then 'cc1d512b1c57994803eed9107a692277d32dfb9d6ebccb3e531eec17ee9d1c07'
      when '4.9.1' then 'cc8833c9f69f9f33f89ca0a7ebd7efe2e604b5e37e1e77f3500c26217dfa6855'
      when '4.10.0' then '65c0c672c6ea92c6fb2090d5f8a170b70a90cbb986af8304fc6bb4dce717451b'
      when '4.10.1' then 'f625977f28d1fbbc7231fcea16bac8521fe3427e05063bfe4c1874be275d75cd'
      when '4.10.2' then '003cddaa32597552da689731d155d6e1eebadd24b3768d512dfd15c848463ffc'
      when '4.11.1' then '6595bf57b60b41a770c617171b478ae221de0aee1152a04d829751426b43f632'
      when '4.11.2' then 'c804495c88a9ad3984c4d8c84260ca22bc4b5d6c4fa59fb510554fafcd2c868e'
      when '4.12.0' then '50be63a7b94863c7d51fd269fb91143d256cf560476a1b6f46f0ed07a53a4914'
      when '4.12.1' then '8ea5f0e145c4bcbec9879c8ac2d124329d000b9c4b74ce78408b0629a9ef1664'
      when '4.13.0' then 'c98f343f51f81db6ebb7cf3e84737b07cdc7e919aeb039fa1fe1fe638b69971a'
      when '4.13.1' then 'dec55ed960c92f6740c025bb6d28a4182c4362b1ea795b39803601af0401cd12'
      when '4.14.0' then '6a5f020d0511df2da0550632fa863908233901f7436a8afd50d6e87d2bc04000'
      when '4.14.1' then '8cfdfb39624686837a02ad50ff18de28d3de5bb3f8642821ab5049fd197faf67'
      when '4.14.2' then '7d57355551db54d24f2dce768e602ecc3581cdf11431e0da2ec1a2c67fc46c12'
      when '4.14.3' then '2d54b9424dbfe3a8a65dd8d908cfe670ace7cf2bfb597753c2048e1cf321f259'
      when '4.14.4' then 'ba58a5be4064515613cbb3825f2dafd8ceaa9749fd1905a7b5a65f30247be337'
      when '4.14.5' then 'f366fc5f4a1b1a41c3daa123d1f18fa166092dc479604694ef3e221b6d4e1f81'
      when '4.14.6' then '2edb1df912215df4df4304d2fac2a6e9135db72c2dca536046e6bdfc320ff592'
      when '4.14.7' then '1919a2667fdfa229500f15b14a458c106114b97be8cba5171b5a69a72467bf86'
      when '4.14.8' then '94179570e3f3680437525e623bf92ccb2dcde148ae35a5a4055dd7c67c603c93'
      when '4.14.9' then '249cc8d54cec47f4901234c621f3cb85dcf3350d873da6b6bfcbec74c59e1051'
      when '4.14.10' then '3e8fa1a21d858b65463f3416d97e468ccc52f955a079b679d72b2e826f8a4751'
      when '4.14.11' then '11454a980da681e52cae78001d2bd43d291cfe32da101a7269bd8c37d7f6602f'
      when '4.14.12' then 'd131ddcaf294139e27aaaaf7583fd9fc2a8d3cca056a92f6c5a68363313a0a26'
      when '5.0.2' then 'b0a5d15f24891a7bd5bf04a4f6c015a4bf3483111475e642badafc0616e7559b'
      when '5.0.4' then '2b1d4c5aa1074e51050ba834d5aa77cd043211542d8d44b3d4dbcf054f2d72f3'
      when '5.0.5' then '499246c3f5f5d4ef25a757aee9afee7b54183db9a4a1bfe0835b91a56385083f'
      when '5.0.6' then 'd75ec7e6e52f0d3fc311073725df73c51f22999def533ff656050c202827e1b5'
      when '5.0.7' then '0015fd0ad2c6a810c2799079ca2b40aa3da6de8203ddd4be324abffecafe5d84'
      when '5.0.8' then '3a6b5a52247663bf22cc88cc7f82fc358f2ff08fb0a02091253fe278ae42bc36'
      when '5.0.9' then '6550f4911274196dc59fb08747c04e061189024b94916e5fa4566c53ec996935'
      when '5.0.10' then '4252cb04d33eaab25cef8d8fde81ba797abd27e174d65c1e0c24bf7ea5507ec1'
      when '5.1.1' then '198276846c21cbff655f7b2939b2694740454ab36cfd57b89113052e46e0a427'
      when '5.1.2' then 'ec639d0801b52a2efa41251e3b67bedf334a9539e557001162eb7d16a4e80435'
      when '5.1.3' then '9cfdee9935c16d84934e0f61538706e1db92ecab82f951e6036d30f4da29ea39'
      when '5.1.4' then '2ea14f924fb7007edd78f01a82b682fc1b08ec85ea6e40ede694b161d0787bf5'
      when '5.1.5' then '0226f487a2637389dca7a025f560837b8b5aababf21d9a59894a506808be7273'
      when '5.1.6' then 'a59cea975c7e0b9084834e27528c3ed580edaf7a9c5f51bb38534916fe219ebd'
      when '5.1.7' then 'e877cafcf9317e0f9ebc2ec47e109d32aa667faf73f59d9172cbe3431dae2f06'
      when '5.1.8' then '0b539efa7643f372602debdbed1ff1336060dbd0f4bbbc5fcfef454410549190'
      when '5.1.9' then 'cadaed991038257268db33c0945efed49c6bc521a95ce2b69ace57d260211488'
      when '5.2.0' then '5038465b5a0be6cbca2d8706b4320be28bbb23bfd9486a8a1518caae1772133e'
      when '5.2.1' then 'a24eb89bd315486b2e163569d068e3ba43c51619ca9c3b226d1f298639715946'
      when '5.2.2' then 'a00068c835411e66cf5d446d928fd87d0adeb79263fa41e46b1c8cd140da2b4c'
      when '5.2.3' then '7e20f9983db4ace1378671bb6e60a12fafcbcccdd7404e7c04e0fd77f461d857'
      when '5.2.4' then 'a90a0beb2992487792f7caa241d65dcbecd1f68be4baf8a265a65accdcc65401'
      when '5.2.5' then '6fb89e504df2220c6be278af2579f0da9dee17958a5a8ea6be1585708d5a4342'
      when '5.2.6' then '59f4739d1107db3d57c6c0fd546290474bcc3180d7fdb43d59af432d7ab19b5a'
      when '5.2.7' then 'cda3d59e1c6ed5d79b054e32469e3885aa66155406be1613d59837e7b330e83e'
      when '5.2.8' then '580ab818ea1d39e9a01ca1c25f45f5c5f5316d5aded7a9f4412a0e7b6ba63c33'
      when '5.3.0' then 'dc029475602dee2902de4fb3ad0a19df1bf9273eb5b387c1c84f54dd774b0f14'
      when '5.3.1' then '91e6d11787d59ab5a33e94cdf0437adaeb1de2bdba1890f06483bbe06ea286f2'
      when '5.3.2' then '9ccf17bc6e828fdb94239a14d9a2b708328c6abf90fd9eeed610e064e3225509'
      when '5.3.3' then '008b57122db1674b36c78d2c854ffee5cc37cc826c7e4e48f05483a5961f5acb'
      when '5.3.4' then 'f66cae71aadd2b08b4c23d8d46e1dcbaa88b9db74cedf58324ecb2d3b12568b5'
      when '5.3.5' then 'eb08e86800064203dbcf87952ae1b0e81e07f03b185b0531e6895c78c9ebb240'
      when '5.3.6' then '794e15b1373b79c46bc2b80abfb9994030985281f43a246783ad9758fd2cf24a'
      when '5.3.7' then 'eb5217138a31bb00c42f0fc2fe38472b8500bffa2f9159cd1c2a71d78751a88d'
      when '5.4.0' then '602ad71dc36d9754402c353726f8b86354898102cb3ef7a01c90264ccf3756e2'
      when '5.4.1' then '45c225060eb9c70e634520613ef9c5025507588c095bc882f422f8ea568c1613'
      when '5.4.2' then 'fc8b8587c3fbdf8b3d05300051b84b9a7120cfe69d1436d0ef0adcc02e3dd381'
      when '5.4.3' then 'eabb981bfb4d27ed7d6527e7982df97e221107aa1769b824e920a3287f9f1c3d'
      when '5.4.4' then 'aeb50c29aaee7836973466a3c5cffad5a8bd02f485bd1d776f55ebc74f391de0'
      when '5.4.6' then '218541c80fd197b34fa6b66785973e20420daf1e6b574b509228a8d527cd015a'
      when '5.4.7' then '5a419179d8b5c801d687c92d4370098b637e65a3e7eccac4aedab9cf57557681'
      when '5.5.0' then 'e30c44a2c6a256bfb92d2bd17732296cf171fced59dbd9773e59ded67460ce71'
      when '5.5.1' then '25f943c05be1359494bcdd21d3a3140d67f8426551bf8c0a1b49182ca4183322'
      when '5.5.2' then 'dea52f2e94bb8932f01d3f5d6d012e5ae79eca43d11435529a95ed51539296e6'
      when '5.5.3' then '33ed497d0a1797d3daee5338755cc8f02d5cd2d532d39fbcefa7fa62ad53bb55'
      when '5.5.4' then 'b3ff23d1e1da56b2dfcb8537b0a4dd2ab8b56c7e342351090327b1c6f0ea88c1'
      when '5.5.5' then 'b66e72ba0a96ee5fb5d7beba3db2d829038fbca5ed4b492649fdc33db2eef32d'
      when '5.5.6' then 'a54161878e3696d6c178bb191a6fa9d74b04be760d4cd66ca6996bc097f70233'
      when '5.5.7' then 'b17251152094a737f7b309d65a00a349ea1af7128a92eebdde72b8f84b83de8c'
      when '5.6.1' then 'fe5a5cc6a2e5b6814928044e90ef11570842c79b6e299cc469d4135a59b411a1'
      when '5.6.2' then 'bc143221606b6aa562965b9ad3cf72733a0991fcfc66004d978abaf0d0c32ab8'
      when '5.6.3' then '7df0c404dc6b5008238f126e7a8d82421b19cc4940d3876e966a4712b547e47c'
      when '5.6.4' then '09b5e1ebc07dbf93567d143984f38da5ce24c7fd8bf3b9e093428f4572ddd5c0'
      when '5.7.0' then '51a65694b64b56e480a2a881adf11457710e5c86f169a3249128350f8ca65adc'
      when '5.7.1' then '2df9a774ec8837b2f49043e2b8003f7d5eb9d31e363cd4131e506ba8939b36cc'
      when '5.7.2' then '592d7c6a7346d339e02fe65f86b9b2bd8fb72a2dda65b3cc33da113627906ebe'
      when '5.8.0' then '2d9e9d8bbbdc8986ba5ef8fb248addc79f94adff041efd137eea49a99b93ec9d'
      when '5.9.0' then '69917237813ba1fde116e32d2606d1df22a185e34374623560cf96d10e5ddb5e'
      else raise "Stash version #{node['stash']['version']} is not supported by this cookbook"
      end
    end
  end
end

# Hash extension class
class Hash
  # Returns a hash that represents the difference between two hashes.
  #
  #   {1 => 2}.diff(1 => 2)         # => {}
  #   {1 => 2}.diff(1 => 3)         # => {1 => 2}
  #   {}.diff(1 => 2)               # => {1 => 2}
  #   {1 => 2, 3 => 4}.diff(1 => 2) # => {3 => 4}
  def diff(other)
    d = dup.delete_if { |k, v| other[k] == v }
    d.merge!(other.dup.delete_if { |k, _v| key?(k) })
  end
end

::Chef::Recipe.send(:include, Stash::Helper)
::Chef::Resource.send(:include, Stash::Helper)
