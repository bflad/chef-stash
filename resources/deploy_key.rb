# frozen_string_literal: true

actions :create
default_action :create

attribute :alias, :kind_of => String, :name_attribute => true

attribute :key, :kind_of => String, :required => true

attribute :owner, :kind_of => String, :default => nil
