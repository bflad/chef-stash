# frozen_string_literal: true

actions :enable, :configure, :disable
default_action :configure

attribute :hook, :kind_of => String, :name_attribute => true
attribute :server, :kind_of => String
attribute :project, :kind_of => String
attribute :repo, :kind_of => String
attribute :settings, :kind_of => Hash, :default => nil
attribute :user, :kind_of => String
attribute :chef_vault_version, :kind_of => String, :default => '1.2.0'
attribute :chef_vault_source, :kind_of => String, :default => 'http://rubygems.org'

attr_accessor :enabled, :configured
