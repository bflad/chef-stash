# frozen_string_literal: true

# rubocop:disable Style/MixinUsage
include Stash::Helper
# rubocop:enable Style/MixinUsage

def whyrun_supported?
  true
end

action :enable do
  server = @new_resource.server
  user = @new_resource.user
  hook_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo,
    'hook' => @new_resource.hook
  }

  unless @current_resource.enabled
    converge_by("Enable #{@new_resource}") do
      enable(server, user, hook_opts)
    end
  end
end

action :configure do
  server = @new_resource.server
  user = @new_resource.user
  hook_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo,
    'hook' => @new_resource.hook
  }
  settings = @new_resource.settings

  unless @current_resource.configured && settings.diff(@current_resource.settings).empty?
    converge_by("Configure #{@new_resource}") do
      configure(server, user, hook_opts, settings)
    end
  end
end

action :disable do
  server = @new_resource.server
  user = @new_resource.user
  hook_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo,
    'hook' => @new_resource.hook
  }

  if @current_resource.enabled
    converge_by("Disable #{@new_resource}") do
      disable(server, user, hook_opts)
    end
  end
end

# rubocop:disable Metrics/AbcSize
def load_current_resource
  server = @new_resource.server
  user = @new_resource.user
  hook_opts = {
    'project' => @new_resource.project,
    'repo' => @new_resource.repo,
    'hook' => @new_resource.hook
  }

  # Make sure chef-vault is installed
  install_chef_vault(@new_resource.chef_vault_source, @new_resource.chef_vault_version)

  @current_resource = Chef::Resource::StashHook.new(hook_opts['hook'])
  @current_resource.enabled = enabled?(server, user, hook_opts)
  @current_resource.configured = configured?(server, user, hook_opts)

  @current_resource.settings hook_settings(server, hook_opts) if @current_resource.configured
end
# rubocop:enable Metrics/AbcSize

private

def enabled?(server, user, hook_opts)
  uri = stash_uri(server, hook_base_uri(hook_opts))

  response = stash_get(uri, user)

  details = JSON.parse(response.read_body)
  details['enabled']
end

def configured?(server, user, hook_opts)
  uri = stash_uri(server, hook_base_uri(hook_opts))

  response = stash_get(uri, user)

  details = JSON.parse(response.read_body)
  details['configured']
end

def hook_base_uri(hook_opts)
  "projects/#{hook_opts['project']}/repos/#{hook_opts['repo']}/settings/hooks/#{hook_opts['hook']}"
end

def hook_enabled_uri(hook_opts)
  "projects/#{hook_opts['project']}/repos/#{hook_opts['repo']}/settings/hooks/#{hook_opts['hook']}/enabled"
end

def hook_settings_uri(hook_opts)
  "projects/#{hook_opts['project']}/repos/#{hook_opts['repo']}/settings/hooks/#{hook_opts['hook']}/settings"
end

def hook_settings(server, user, hook_opts)
  uri = stash_uri(server, hook_settings_uri(hook_opts))

  response = stash_get(uri, user)
  hook_settings = JSON.parse(response.read_body)
  hook_settings
end

def enable(server, user, hook_opts)
  Chef::Log.debug("Enabling #{hook_opts['hook']} on #{hook_opts['repo']}...")
  uri = stash_uri(server, hook_enabled_uri(hook_opts))
  stash_put(uri, user)
end

def configure(server, user, hook_opts, settings)
  Chef::Log.debug("Configuring #{hook_opts['hook']} on #{hook_opts['repo']}...")
  uri = stash_uri(server, hook_settings_uri(hook_opts))
  stash_put(uri, user, settings.to_json)
end

def disable(server, user, hook_opts)
  Chef::Log.debug("Disabling #{hook_opts['hook']} on #{hook_opts['repo']}...")
  uri = stash_uri(server, hook_enabled_uri(hook_opts))
  stash_delete(uri, user)
end
