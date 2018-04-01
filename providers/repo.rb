# frozen_string_literal: true

# rubocop:disable Style/MixinUsage
include Stash::Helper
# rubocop:enable Style/MixinUsage

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
  end
end

def load_current_resource
  server = @new_resource.server
  user = @new_resource.user
  repo_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo
  }

  # Make sure chef-vault is installed
  install_chef_vault(@new_resource.chef_vault_source, @new_resource.chef_vault_version)

  @current_resource = Chef::Resource::StashRepo.new(repo_opts['repo'])
  @current_resource.exists = exists?(server, user, repo_opts)
end

private

def project_repos_uri(repo_opts)
  "projects/#{repo_opts['project']}/repos"
end

def repo_uri(repo_opts)
  "projects/#{repo_opts['project']}/repos/#{repo_opts['repo']}"
end

def exists?(server, user, repo_opts)
  uri = stash_uri(server, repo_uri(repo_opts))

  response = stash_get(uri, user, %w[200 404])
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
