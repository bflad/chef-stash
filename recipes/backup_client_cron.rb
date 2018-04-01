# frozen_string_literal: true

handle_old_stash_attributes!

Chef::Log.warn <<~WARN
  Recipe 'stash::backup_client_cron' is deprecated. Please, set attrite
  `node['stash']['backup']['crone']['enable'] = true` to configure crond to run
  Stash backup periodically. This recipe will be removed in the next major release
  of the 'stash' cookbook.
WARN

settings = settings = merge_stash_settings

cron_d 'atlassian-stash-backup-client' do
  hour settings['backup']['cron']['hour']
  minute settings['backup']['cron']['minute']
  day settings['backup']['cron']['day']
  month settings['backup']['cron']['month']
  weekday settings['backup']['cron']['weekday']
  command "java -jar #{node['stash']['backup_client']['install_path']}/stash-backup-client/stash-backup-client.jar"
  user node['stash']['user']
  action(settings['backup']['cron']['enable'] ? :create : :delete)
end
