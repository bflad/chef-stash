#
# Cookbook Name:: stash
# Library:: stash
#
# Copyright 2013
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

class Chef::Recipe::Stash
  def self.settings(node)
    begin
      if Chef::Config[:solo]
        begin 
          settings = Chef::DataBagItem.load("stash","stash")['local']
        rescue
          Chef::Log.info("No stash data bag found")
        end
      else
        begin 
          settings = Chef::EncryptedDataBagItem.load("stash","stash")[node.chef_environment]
        rescue
          Chef::Log.info("No stash encrypted data bag found")
        end
      end
    ensure    
      settings ||= node['stash']

      case settings['database']['type']
      when "mysql"
        settings['database']['port'] ||= 3306
      when "postgresql"
        settings['database']['port'] ||= 5432
      when "sqlserver"
        settings['database']['port'] ||= 1433
      else
        Chef::Log.warn("Unsupported database type.")
      end
    end

    settings
  end
end