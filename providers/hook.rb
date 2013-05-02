#
# Cookbook Name:: stash
# Provider:: hook
#
# Copyright 2013-2014, Nordstrom, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#
def whyrun_supported?
  true
end

action :enable do
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo
  hook = @new_resource.hook
  settings = @new_resource.settings

  unless @current_resource.enabled
    converge_by("Enable #{ @new_resource }") do
      enable(server, user, project, repo, hook)
    end
  end
end

action :configure do
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo
  hook = @new_resource.hook
  settings = @new_resource.settings

  unless @current_resource.configured && settings.diff(@current_resource.settings).empty?
    converge_by("Configure #{ @new_resource }") do
      configure(server, user, project, repo, hook, settings)
    end
  end
end

action :disable do
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo
  hook = @new_resource.hook
  settings = @new_resource.settings

  if @current_resource.enabled
    converge_by("Disable #{ @new_resource }") do
      disable(server, user, project, repo, hook)
    end
  end
end

def load_current_resource
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo
  hook = @new_resource.hook

  @current_resource = Chef::Resource::StashHook.new(hook)
  @current_resource.enabled = enabled?(server, user, project, repo, hook)
  @current_resource.configured = configured?(server, user, project, repo, hook)
  
  if @current_resource.configured
    @current_resource.settings = hook_settings(server, user, project, repo, hook)
  end
end

private
def enabled?(server, user, project, repo, hook)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}")

  response = stash_get(uri, user)

  details = JSON.parse(response.read_body)
  response.code == "200" && details["enabled"]
end

def configured?(server, user, project, repo, hook)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}")

  response = stash_get(uri, user)

  details = JSON.parse(response.read_body)
  response.code == "200" && details["configured"]
end

def hook_settings(server, user, project, repo, hook)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}/settings")

  response = stash_get(uri, user)
  hook_settings = JSON.parse(response.read_body)
  hook_settings
end

def enable(server, user, project, repo, hook)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}/enabled")
  stash_put(uri, user)
end

def configure(server, user, project, repo, hook, settings)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}/settings")
  stash_put(uri, user, settings)
end

def disable(server, user, project, repo, hook)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}/settings/hooks/#{hook}/enabled")
  stash_delete(uri, user)
end
