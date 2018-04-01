# frozen_string_literal: true

module Stash
  # Stash::Library module
  module Library
    # rubocop:disable Metrics/AbcSize

    # Merges Stash settings from data bag and node attributes.
    # Data dag settings always has a higher priority.
    #
    # @return [Hash] Settings hash
    def merge_stash_settings
      @settings_from_data_bag ||= settings_from_data_bag
      settings = Chef::Mixin::DeepMerge.deep_merge(
        @settings_from_data_bag,
        node['stash'].to_hash
      )

      settings['database']['port'] ||=
        case settings['database']['type']
        when 'mysql' then 3306
        when 'postgresql' then 5432
        when 'sqlserver' then 1433
        else fatal "Unsupported database type: #{settings['database']['type']}"
        end

      settings['database']['query_string'] ||=
        case settings['database']['type']
        when 'mysql' then '?autoReconnect=true&characterEncoding=utf8&useUnicode=true&sessionVariables=storage_engine%3DInnoDB'
        else ''
        end

      settings
    end

    def handle_old_stash_attributes!
      backup_attrs = %w[backup_path baseurl password user cron]
      show_warn = false
      backup_attrs.each do |attr|
        next if node['stash']['backup_client'][attr].nil?

        node.default['stash']['backup'][attr] = node['stash']['backup_client'][attr]
        Chef::Log.warn "node['stash']['backup_client']['#{attr}'] has been changed to node['stash']['backup']['#{attr}']"
        show_warn = true
      end
      Chef::Log.warn <<-WARN if show_warn
        This renaming introduces the common approach for both of backup strategies:
        'backup_client' and 'backup_diy'. Attributes mentioned above will be gracefully
        converted for you, but this warning and conversion will be removed in the next
        major release of the 'stash' cookbook.
      WARN
    end
    # rubocop:enable Metrics/AbcSize

    private

    # Fetches Stash settings from the data bag
    #
    # @return [Hash] Settings hash
    def settings_from_data_bag
      begin
        item = data_bag_item(node['stash']['data_bag_name'],
                             node['stash']['data_bag_item'])['stash']
        return item if item.is_a?(Hash)
      rescue StandardError
        Chef::Log.info('No stash data bag found')
      end
      {}
    end
  end
end

::Chef::Recipe.send(:include, Stash::Library)
::Chef::Resource.send(:include, Stash::Library)
