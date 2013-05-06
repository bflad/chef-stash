#
# Cookbook Name:: stash
# Provider:: repo
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

include Stash::Helper

def whyrun_supported?
  true
end

action :create do
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo

  unless @current_resource.exists
    converge_by("Creating #{ @new_resource }") do
      create(server, user, project, repo)
    end
  end
end

action :delete do
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo

  if @current_resource.exists
    converge_by("Deleting #{ @new_resource }") do
      delete(server, user, project, repo)
    end
  end
end

def load_current_resource
  server = @new_resource.server
  user = @new_resource.user
  project = @new_resource.project
  repo = @new_resource.repo

  # Make sure chef-vault is installed
  install_chef_vault(@new_resource.chef_vault_source, @new_resource.chef_vault_version)

  @current_resource = Chef::Resource::StashRepo.new(repo)
  @current_resource.exists = exists?(server, user, project, repo)
end

private
def exists?(server, user, project, repo)
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}")

  response = stash_get(uri, user, ["200", "404"])
  response.code == "200"  
end

def create(server, user, project, repo)
  Chef::Log.debug("Creating #{repo} in #{project}...")
  uri = stash_uri(server, "projects/#{project}/repos")
  settings = {
    "name" => repo
  }
  stash_post(uri, user, settings.to_json, ["201"])
end

def delete(server, user, project, repo)
  Chef::Log.debug("Deleting #{repo} in #{project}...")
  uri = stash_uri(server, "projects/#{project}/repos/#{repo}")
  stash_delete(uri, user, ["202"])
end
