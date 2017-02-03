# frozen_string_literal: true
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'spec_helper'
require 'capybara/rspec'
require 'rspec/its'

Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

ActiveRecord::Migration.maintain_test_schema!

Capybara.default_driver = :selenium
Capybara.default_max_wait_time = 5

module Features
  include Formulaic::Dsl
  include SelectDateHelpers
  include SessionHelpers
  include SidekiqHelpers
end

RSpec.configure do |config|
  config.reset
  config.infer_base_class_for_anonymous_controllers = false
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = false

  config.include Features, type: :feature
  config.include ActiveJob::TestHelper, type: :job
  config.include Devise::Test::ControllerHelpers, type: :controller
  config.include Warden::Test::Helpers
  config.before(:suite) { Warden.test_mode!  }
  config.after(:each)   { Warden.test_reset! }
end
