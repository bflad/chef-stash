Stash.check_for_old_attributes!(node)

settings = Stash.settings(node)

cron_d 'atlassian-stash-backup-client' do
  hour settings['backup']['cron']['hour']
  minute settings['backup']['cron']['minute']
  day settings['backup']['cron']['day']
  month settings['backup']['cron']['month']
  weekday settings['backup']['cron']['weekday']
  command "java -jar #{node['stash']['backup_client']['install_path']}/stash-backup-client/stash-backup-client.jar"
  user node['stash']['user']
end
