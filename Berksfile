# frozen_string_literal: true
source 'https://supermarket.chef.io'

metadata

group :integration do
  cookbook 'apt'
  cookbook 'java',
    # Pending release: ark_java fails when tar is not installed
    # See: https://github.com/agileorbit-cookbooks/java/issues/263
    github: 'agileorbit-cookbooks/java'
  cookbook 'test-helper',
    # Pending release: Add ohai attribute support (automatic attrs)
    # Ref: https://github.com/lipro-cookbooks/test-helper/pull/2
    github: 'lipro-cookbooks/test-helper'
  cookbook 'yum'
end
