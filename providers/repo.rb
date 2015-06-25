include Stash::Helper

def whyrun_supported?
  true
end

action :create do
  server = @new_resource.server
  user = @new_resource.user
  repo_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo
  }

  unless @current_resource.exists
    converge_by("Creating #{@new_resource}") do
      create(server, user, repo_opts)
    end
  end
  update_perms(server, user, repo_opts, 'group', 'REPO_ADMIN', @current_resource.admin_groups, @new_resource.admin_groups)
  update_perms(server, user, repo_opts, 'group', 'REPO_WRITE', @current_resource.write_groups, @new_resource.write_groups)
  update_perms(server, user, repo_opts, 'group', 'REPO_READ', @current_resource.read_groups, @new_resource.read_groups)
  update_perms(server, user, repo_opts, 'user', 'REPO_ADMIN', @current_resource.admin_users, @new_resource.admin_users)
  update_perms(server, user, repo_opts, 'user', 'REPO_WRITE', @current_resource.write_users, @new_resource.write_users)
  update_perms(server, user, repo_opts, 'user', 'REPO_READ', @current_resource.read_users, @new_resource.read_users)

  # TODO: fix this to reflect if change actually happened
  new_resource.updated_by_last_action(true)
end

action :delete do
  server = @new_resource.server
  user = @new_resource.user
  repo_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo
  }

  if @current_resource.exists
    converge_by("Deleting #{@new_resource}") do
      delete(server, user, repo_opts)
    end
    new_resource.updated_by_last_action(true)
  end
end

def load_current_resource
  server = @new_resource.server
  login_user = @new_resource.user
  repo_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo
  }

  # Make sure chef-vault is installed
  install_chef_vault(@new_resource.chef_vault_source, @new_resource.chef_vault_version)

  @current_resource = Chef::Resource::StashRepo.new(repo_opts['repo'])
  @current_resource.exists = exists?(server, login_user, repo_opts)

  # Load in existing permissions if the repo already exists
  get_group_permissions(server, login_user, repo_opts) if @current_resource.exists
  get_user_permissions(server, login_user, repo_opts) if @current_resource.exists
end

private

def get_group_permissions(server, login_user, repo_opts)
  groups = stash_get_paged(stash_uri(server, "projects/#{repo_opts['project']}/repos/#{repo_opts['repo']}/permissions/groups"), login_user)
  groups.each do |group|
    Chef::Log.debug("Group name: #{group['group']['name']} permission: #{group['permission']}")
    case group['permission']

    when 'REPO_ADMIN'
      @current_resource.admin_groups.push(group['group']['name'])
    when 'REPO_WRITE'
      @current_resource.write_groups.push(group['group']['name'])
    when 'REPO_READ'
      @current_resource.read_groups.push(group['group']['name'])
    end
  end
end

def get_user_permissions(server, login_user, repo_opts)
  users = stash_get_paged(stash_uri(server, "projects/#{repo_opts['project']}/repos/#{repo_opts['repo']}/permissions/users"), login_user)
  users.each do |user|
    case user['permission']

    when 'REPO_ADMIN'
      @current_resource.admin_users.push(user['user']['name'])
    when 'REPO_WRITE'
      @current_resource.user_users.push(user['user']['name'])
    when 'REPO_READ'
      @current_resource.read_users.push(user['user']['name'])
    end
  end
end

def project_repos_uri(repo_opts)
  "projects/#{repo_opts['project']}/repos"
end

def repo_uri(repo_opts)
  "projects/#{repo_opts['project']}/repos/#{repo_opts['repo']}"
end

def exists?(server, user, repo_opts)
  uri = stash_uri(server, repo_uri(repo_opts))

  response = stash_get(uri, user, %w(200 404))
  response.code == '200'
end

def create(server, user, repo_opts)
  Chef::Log.debug("Creating #{repo_opts['repo']} in #{repo_opts['project']}...")
  uri = stash_uri(server, project_repos_uri(repo_opts))
  settings = {
    'name' => repo_opts['repo']
  }
  stash_post(uri, user, settings.to_json, ['201'])
end

def delete(server, user, repo_opts)
  Chef::Log.debug("Deleting #{repo_opts['repo']} in #{repo_opts['project']}...")
  uri = stash_uri(server, repo_uri(repo_opts))
  stash_delete(uri, user, ['202'])
end

def update_perms(server, user, repo_opts, type, permission, current_list, new_list)
  to_add = new_list - current_list
  to_remove = current_list - new_list
  base_uri = "projects/#{repo_opts['project']}/repos/#{repo_opts['repo']}/permissions/#{type}s"
  to_add.each do |item|
    converge_by("add #{permission} to #{type} #{item} on repo #{repo_opts['repo']} in project #{repo_opts['project']}") do
      uri = stash_uri(server, "#{base_uri}?permission=#{permission}&name=#{item}")
      Chef::Log.debug "Stash Request: PUT |#{uri.request_uri}|"
      stash_put(uri, user, nil, ['204'])
    end
  end

  to_remove.each do |item|
    converge_by("remove #{permission} from #{type} #{item} on repo #{repo_opts['repo']} in project #{repo_opts['project']}") do
      uri = stash_uri(server, "#{base_uri}?name=#{item}")
      Chef::Log.debug "Stash Request: DELETE |#{uri.request_uri}|"
      stash_delete(uri, user, ['204'])
    end
  end
end
