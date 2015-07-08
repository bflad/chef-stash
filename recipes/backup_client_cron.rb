Stash.check_for_old_attributes!(node)

Chef::Log.warn <<-EOH
Recipe 'stash::backup_client_cron' is deprecated. Please, set attrite
`node['stash']['backup']['crone']['enable'] = true` to configure crond to run
Stash backup periodically. This recipe will be removed in the next major release
of the 'stash' cookbook.
EOH

settings = Stash.settings(node)

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
