# Cookbook module
module Stash
  # Helper module
  module Helper
    REST_BASE = 'rest/api/1.0'

    def stash_uri(host, rest_endpoint)
      URI.parse(stash_url(host, rest_endpoint))
    end

    def stash_url(host, rest_endpoint)
      "https://#{host}/#{REST_BASE}/#{rest_endpoint}"
    end

    def stash_base64_creds(user)
      vault = ChefVault.new('passwords')
      user_vault = vault.user(user)
      Base64.encode64("#{user}:#{user_vault.decrypt_password}").strip!
    end

    def stash_put(uri, user, json = nil, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Put.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"
      request.content_type = 'application/json'
      request.body = json if json

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_post(uri, user, json = nil, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Post.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"
      request.content_type = 'application/json'
      request.body = json if json

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_get(uri, user, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Get.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def stash_delete(uri, user, success_codes = ['200'])
      http = Net::HTTP.new(uri.host, uri.port)
      http.use_ssl = true
      http.verify_mode = OpenSSL::SSL::VERIFY_NONE

      request = Net::HTTP::Delete.new(uri.request_uri)
      request['AUTHORIZATION'] = "Basic #{stash_base64_creds(user)}"

      response = http.request(request)
      check_for_errors(response, success_codes)
      response
    end

    def check_for_errors(http_response, success_codes)
      return if success_codes.include?(http_response.code)
      Chef::Log.debug("http response code: #{http_response.code}")
      Chef::Log.debug("http response body: #{http_response.read_body}")
      Chef::Application.fatal!('error making stash request')
    end

    def install_chef_vault(source = 'http://rubygems.org', version = '1.2.0')
      gem_installer = Chef::Resource::ChefGem.new('chef-vault', run_context)
      gem_installer.version version
      gem_installer.options "--clear-sources --source #{source}"
      gem_installer.action :install
      gem_installer.after_created

      require 'chef-vault'
    end
  end
end

# Hash extension class
class Hash
  # Returns a hash that represents the difference between two hashes.
  #
  #   {1 => 2}.diff(1 => 2)         # => {}
  #   {1 => 2}.diff(1 => 3)         # => {1 => 2}
  #   {}.diff(1 => 2)               # => {1 => 2}
  #   {1 => 2, 3 => 4}.diff(1 => 2) # => {3 => 4}
  def diff(other)
    d = dup.delete_if { |k, v| other[k] == v }
    d.merge!(other.dup.delete_if { |k, _v| key?(k) })
  end
end
