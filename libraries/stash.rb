# Chef class
class Chef
  # Chef::Recipe class
  class Recipe
    # Chef::Recipe::Stash class
    class Stash
      # rubocop:disable Metrics/AbcSize
      def self.settings(node)
        begin
          if Chef::Config[:solo]
            begin
              databag_item = Chef::DataBagItem.load('stash', 'stash')['local']
            rescue
              Chef::Log.info('No stash data bag found')
            end
          else
            begin
              databag_item = Chef::EncryptedDataBagItem.load('stash', 'stash')[node.chef_environment]
            rescue
              Chef::Log.info('No stash encrypted data bag found')
            end
          end
        ensure
          databag_item ||= {}
          settings = Chef::Mixin::DeepMerge.deep_merge(databag_item, node['stash'].to_hash)
          settings['database']['port'] ||= Stash.default_database_port(settings['database']['type'])
        end

        settings
      end
      # rubocop:enable Metrics/AbcSize

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
