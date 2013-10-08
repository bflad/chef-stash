
settings = Stash.settings(node)

cron_d 'atlassian-stash-backup-client' do
  hour settings['backup_client']['cron']['hour']
  minute settings['backup_client']['cron']['minute']
  day settings['backup_client']['cron']['day']
  month settings['backup_client']['cron']['month']
  weekday settings['backup_client']['cron']['weekday']
  command "java -jar #{node['stash']['backup_client']['install_path']}/stash-backup-client/stash-backup-client.jar"
  user node['stash']['user']
end
