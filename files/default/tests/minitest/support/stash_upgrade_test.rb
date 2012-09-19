require "minitest/autorun"

describe_recipe "stash::upgrade" do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
end
