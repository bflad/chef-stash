site :opscode

metadata

cookbook 'mysql', '3.0.12'
cookbook 'mysql_connector', github: 'bflad/chef-mysql_connector'

group :integration do
  cookbook "java"
  cookbook "minitest-handler"
  cookbook "stash_test", :path => "test/cookbooks/stash_test"
end
