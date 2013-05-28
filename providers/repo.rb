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
  approvers = @new_resource.pull_request_approvers
  builds = @new_resource.pull_request_builds

  unless @current_resource.exists
    converge_by("Creating #{ @new_resource }") do
      create(server, user, project, repo)
    end
  end

  unless @current_resource.pull_request_approvers == approvers && @current_resource.pull_request_builds == builds
    converge_by("Configuring #{ @new_resource }") do
      configure(server, user, project, repo, approvers, builds)
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
  # Make sure nokogiri is installed
  install_nokogiri(@new_resource.nokogiri_source, @new_resource.nokogiri_version)

  @current_resource = Chef::Resource::StashRepo.new(repo)
  @current_resource.exists = exists?(server, user, project, repo)

  if @current_resource.exists
    settings = pull_request_settings(server, user, project, repo)
    @current_resource.pull_request_approvers settings[:approvers]
    @current_resource.pull_request_builds settings[:builds]
  end
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

def pull_request_settings(server, user, project, repo)
  uri = URI.parse("https://#{server}/projects/#{project}/repos/#{repo}/settings/pull-requests")
  settings = Nokogiri::HTML(stash_web_get(uri, user).read_body)
  builds = settings.css("#requiredCount").first
  approvers = settings.css("#requiredApproversCount").first

  configuration = {}
  unless approvers.has_attribute?("disabled")
    approvers.css("option").each do |option|
      if option.has_attribute?("selected")
        configuration[:approvers] = option.attribute("value").value.to_i
      end
    end
  end

  unless builds.has_attribute?("disabled")
    builds.css("option").each do |option|
      if option.has_attribute?("selected")
        configuration[:builds] = option.attribute("value").value.to_i
      end
    end
  end

  configuration
end

def configure(server, user, project, repo, approvers, builds)
  Chef::Log.debug("Configuring #{approvers} approvers and #{builds} successfull builds for pull requests on #{repo} in #{project}")
  uri = URI.parse("https://#{server}/projects/#{project}/repos/#{repo}/settings/pull-requests")

  settings = Nokogiri::HTML(stash_web_get(uri, user).read_body)
  atl_token = settings.css("input[name=atl_token]").first.attribute("value")
  form_data = "requiredCount=#{builds}&requiredApproversCount=#{approvers}&submit=Save&atl_token=#{atl_token}"

  stash_web_post(uri, user, form_data, ["200", "302"])
end
