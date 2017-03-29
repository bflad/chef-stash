# frozen_string_literal: true

actions :create, :delete
default_action :create

attribute :server, :kind_of => String
attribute :project, :kind_of => String
attribute :repo, :kind_of => String, :name_attribute => true
attribute :user, :kind_of => String
attribute :chef_vault_version, :kind_of => String, :default => '1.2.0'
attribute :chef_vault_source, :kind_of => String, :default => 'http://rubygems.org'

attr_accessor :exists
