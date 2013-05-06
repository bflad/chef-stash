#
# Cookbook Name:: stash
# Library:: helper
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

module Stash
  module Helper
    REST_BASE = "rest/api/1.0"

    def stash_uri(host, rest_endpoint)
      URI.parse(stash_url(host, rest_endpoint))
    end

    def stash_url(host, rest_endpoint)
      "https://#{host}/#{REST_BASE}/#{rest_endpoint}"
    end

    def stash_base64_creds(user)
      vault = ChefVault.new("passwords")
      user_vault = vault.user(user)
      Base64.encode64("#{user}:#{user_vault.decrypt_password}").strip!
    end

    def stash_put(uri, user, json=nil)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Put.new(uri.request_uri)
      request["AUTHORIZATION"] = "Basic #{stash_base64_creds(user)}"
      request.content_type = 'application/json'
      request.body = json if json

      response = http.request(request)
      check_for_errors(response)
      response
    end

    def stash_get(uri, user)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      request["AUTHORIZATION"] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response)
      response
    end

    def stash_delete(uri, user)
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Delete.new(uri.request_uri)
      request["AUTHORIZATION"] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response)
      response
    end

    def check_for_errors(http_response)
      unless http_response.code == "200"
        Chef::Log.debug("http response code: #{http_response.code}")
        Chef::Log.debug("http response body: #{http_response.read_body}")
        Chef::Application.fatal!("error making stash request")
      end
    end

    def install_chef_vault(source="http://rubygems.org", version="1.2.0")
      gem_installer = Chef::Resource::ChefGem.new("chef-vault", run_context)
      gem_installer.version version
      gem_installer.options "--clear-sources --source #{source}"
      gem_installer.action :install
      gem_installer.after_created

      require 'chef-vault'
    end
  end
end

class Hash
  # Returns a hash that represents the difference between two hashes.
  #
  #   {1 => 2}.diff(1 => 2)         # => {}
  #   {1 => 2}.diff(1 => 3)         # => {1 => 2}
  #   {}.diff(1 => 2)               # => {1 => 2}
  #   {1 => 2, 3 => 4}.diff(1 => 2) # => {3 => 4}
  def diff(other)
    dup.delete_if { |k, v| other[k] == v }.
      merge!(other.dup.delete_if { |k, v| has_key?(k) })
  end
end
