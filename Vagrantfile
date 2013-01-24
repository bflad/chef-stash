require 'berkshelf/vagrant'

# We'll mount the Chef::Config[:file_cache_path] so it persists between
# Vagrant VMs
host_cache_path = File.expand_path("../.cache", __FILE__)
guest_cache_path = "/tmp/vagrant-cache"

# ensure the cache path exists
FileUtils.mkdir(host_cache_path) unless File.exist?(host_cache_path)

Vagrant::Config.run do |config|

  config.vm.define :centos6 do |dist_config|
    dist_config.vm.host_name = 'stash-centos-6'
    dist_config.vm.box       = 'opscode-centos-6.3'
    dist_config.vm.box_url   = 'https://opscode-vm.s3.amazonaws.com/vagrant/boxes/opscode-centos-6.3.box'

    
    dist_config.vm.customize ["modifyvm", :id, "--memory", 1024]
    dist_config.vm.network :hostonly, '33.33.33.10'

    dist_config.vm.share_folder "cache", guest_cache_path, host_cache_path

    dist_config.vm.provision :chef_solo do |chef|
      chef.provisioning_path = guest_cache_path
      #chef.log_level         = :debug

      chef.json = {
        "java" => {
          "install_flavor" => "oracle"
        }
      }

      chef.run_list = %w{
        recipe[stash]
        recipe[stash::apache2]
      }
    end
  end
end