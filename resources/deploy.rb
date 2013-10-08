#
# Cookbook Name:: stash
# Resource:: deploy
#
# Copyright 2012
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

actions :deploy

attribute :destination, :kind_of => String, :name_attribute => true

attribute :deploy_key, :kind_of => String, :required => true
attribute :project, :kind_of => String, :required => true
attribute :repository, :kind_of => String, :required => true

attribute :deploy_action, :kind_of => Symbol, :default => :sync
attribute :group, :kind_of => String, :default => nil
attribute :revision, :kind_of => String, :default => 'HEAD'
attribute :user, :kind_of => String, :default => nil

def initialize(*args)
  super
  @action = :deploy
end
