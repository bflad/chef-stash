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

      def self.check_for_old_attributes!(node)
        backup_attrs = %w(backup_path baseurl password user cron)
        backup_attrs.each do |attr|
          unless node['stash']['backup_client'][attr].nil?
            node.default['stash']['backup_client'][attr] = node['stash']['backup'][attr]
            Chef::Log.warn "node['stash']['backup_client']['#{attr}'] has been changed to node['stash']['backup']['#{attr}']"
          end
        end
        Chef::Log.warn <<-EOH
This renaming introduces the common approach for both of backup strategies:
'backup_client' and 'backup_diy'. Attributes metioned above will be gracefully
converted for you, but this warning and conversion will be removed in the next
major release of the 'stash' cookbook.
EOH
      end
    end
  end
end
