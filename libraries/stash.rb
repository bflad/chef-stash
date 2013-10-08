# Cookbook Recipe class
class Chef::Recipe::Stash
  def self.settings(node)
    begin
      if Chef::Config[:solo]
        begin
          settings = Chef::DataBagItem.load('stash', 'stash')['local']
        rescue
          Chef::Log.info('No stash data bag found')
        end
      else
        begin
          settings = Chef::EncryptedDataBagItem.load('stash', 'stash')[node.chef_environment]
        rescue
          Chef::Log.info('No stash encrypted data bag found')
        end
      end
    ensure
      settings ||= node['stash']

      case settings['database']['type']
      when 'mysql'
        settings['database']['port'] ||= 3306
      when 'postgresql'
        settings['database']['port'] ||= 5432
      when 'sqlserver'
        settings['database']['port'] ||= 1433
      else
        Chef::Log.warn('Unsupported database type.')
      end
    end

    settings
  end
end
