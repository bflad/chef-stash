# frozen_string_literal: true

actions :deploy
default_action :deploy

attribute :destination, :kind_of => String, :name_attribute => true

attribute :deploy_key, :kind_of => String, :required => true
attribute :project, :kind_of => String, :required => true
attribute :repository, :kind_of => String, :required => true

attribute :deploy_action, :kind_of => Symbol, :default => :sync
attribute :group, :kind_of => String, :default => nil
attribute :revision, :kind_of => String, :default => 'HEAD'
attribute :user, :kind_of => String, :default => nil
