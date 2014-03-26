# Chef class
class Chef
  # Chef::Recipe class
  class Recipe
    # Chef::Recipe::Stash class
    class Stash
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
          settings['database']['port'] ||= default_database_port settings['database']['type']
          settings['database']['testInterval'] ||= 2
        end

        settings
      end

      def default_database_port(type)
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
