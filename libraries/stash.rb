# Chef class
class Chef
  # Chef::Recipe class
  class Recipe
    # Chef::Recipe::Stash class
    class Stash
      def self.settings(node)
        settings = node['stash'].to_hash

        begin
          if Chef::Config[:solo]
            begin
              settings.merge! Chef::DataBagItem.load('stash', 'stash')['local']
            rescue
              Chef::Log.info('No stash data bag found')
            end
          else
            begin
              settings.merge! Chef::EncryptedDataBagItem.load('stash', 'stash')[node.chef_environment]
            rescue
              Chef::Log.info('No stash encrypted data bag found')
            end
          end
        ensure
          settings['database']['port'] ||= Stash.default_database_port(settings['database']['type'])
        end

        settings
      end

      def self.default_database_port(type)
        case type
        when 'mysql'
          3306
        when 'postgresql'
          5432
        when 'sqlserver'
          1433
        else
          Chef::Log.warn("Unsupported database type (#{type}) in Stash cookbook.")
          Chef::Log.warn('Please add to Stash cookbook or hard set Stash database port.')
          nil
        end
      end
    end
  end
end
