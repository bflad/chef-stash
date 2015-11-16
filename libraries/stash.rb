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
              databag_item = Chef::DataBagItem.load(
                node['stash']['data_bag_name'],
                node['stash']['data_bag_item']
              )['stash']
            rescue
              Chef::Log.info('No stash data bag found')
            end
          else
            begin
              databag_item = Chef::EncryptedDataBagItem.load(
                node['stash']['data_bag_name'],
                node['stash']['data_bag_item']
              )['stash']
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
        show_warn = false
        backup_attrs.each do |attr|
          next if node['stash']['backup_client'][attr].nil?

          node.default['stash']['backup'][attr] = node['stash']['backup_client'][attr]
          Chef::Log.warn "node['stash']['backup_client']['#{attr}'] has been changed to node['stash']['backup']['#{attr}']"
          show_warn = true
        end
        Chef::Log.warn <<-EOH if show_warn
This renaming introduces the common approach for both of backup strategies:
'backup_client' and 'backup_diy'. Attributes mentioned above will be gracefully
converted for you, but this warning and conversion will be removed in the next
major release of the 'stash' cookbook.
EOH
      end
    end
  end
end
