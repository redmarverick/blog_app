# spec/rails_helper.rb

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)

require 'rspec/rails'
require 'spec_helper'

# ... any other configurations you might need

RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  # ... other configurations

  config.shared_context_metadata_behavior = :apply_to_host_groups

  # Add any additional configuration for matchers and such here.
end
