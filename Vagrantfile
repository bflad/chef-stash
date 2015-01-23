# Base hostname
cookbook = 'stash'

Vagrant.configure('2') do |config|
  config.berkshelf.enabled = true
  config.cache.auto_detect = true
  config.omnibus.chef_version = :latest

  config.vm.define :centos6 do |centos6|
    centos6.vm.box      = 'chef/centos-6.6'
    centos6.vm.hostname = "#{cookbook}-centos-6"
  end

  config.vm.define :centos7 do |centos7|
    centos7.vm.box      = 'chef/centos-7.0'
    centos7.vm.hostname = "#{cookbook}-centos-7"
  end

  config.vm.define :debian7 do |debian7|
    debian7.vm.box      = 'chef/debian-7.7'
    debian7.vm.hostname = "#{cookbook}-debian-7"
  end

  config.vm.define :fedora19 do |fedora19|
    fedora19.vm.box      = 'chef/fedora-19'
    fedora19.vm.hostname = "#{cookbook}-fedora-19"
  end

  config.vm.define :fedora20 do |fedora20|
    fedora20.vm.box      = 'chef/fedora-20'
    fedora20.vm.hostname = "#{cookbook}-fedora-20"
  end

  config.vm.define :freebsd9 do |freebsd9|
    freebsd9.vm.box      = 'chef/freebsd-9.2'
    freebsd9.vm.hostname = "#{cookbook}-freebsd-9"
  end

  config.vm.define :freebsd10 do |freebsd10|
    freebsd10.vm.box      = 'chef/freebsd-10.0'
    freebsd10.vm.hostname = "#{cookbook}-freebsd-10"
  end

  config.vm.define :ubuntu1204 do |ubuntu1204|
    ubuntu1204.vm.box      = 'chef/ubuntu-12.04'
    ubuntu1204.vm.hostname = "#{cookbook}-ubuntu-1204"
  end

  config.vm.define :ubuntu1404 do |ubuntu1404|
    ubuntu1404.vm.box      = 'chef/ubuntu-14.04'
    ubuntu1404.vm.hostname = "#{cookbook}-ubuntu-1404"
  end

  config.vm.define :ubuntu1410 do |ubuntu1410|
    ubuntu1410.vm.box      = 'chef/ubuntu-14.04'
    ubuntu1410.vm.hostname = "#{cookbook}-ubuntu-1410"
  end

  config.vm.network :private_network, ip: '192.168.50.10'

  config.vm.provider 'virtualbox' do |v|
    v.customize ['modifyvm', :id, '--memory', 1024]
  end

  config.vm.provision :chef_solo do |chef|
    chef.log_level = :debug
    chef.json = {
      'java' => {
        'install_flavor' => 'oracle',
        'java_home' => '/usr/lib/jvm/java-7-oracle',
        'jdk_version' => '7',
        'oracle' => {
          'accept_oracle_download_terms' => true
        }
      },
      'mysql' => {
        'server_root_password' => 'iloverandompasswordsbutthiswilldo',
        'server_repl_password' => 'iloverandompasswordsbutthiswilldo',
        'server_debian_password' => 'iloverandompasswordsbutthiswilldo'
      }
    }
    chef.run_list = [
      'recipe[java]',
      "recipe[#{cookbook}]",
      'recipe[stash::backup_client_cron]'
    ]
  end
end
