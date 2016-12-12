require_relative 'boot'

require "rails"
require "active_model/railtie"
require "active_job/railtie"
require "active_record/railtie"
require "action_controller/railtie"
require "action_mailer/railtie"
require "action_view/railtie"
require "sprockets/railtie"
Bundler.require(*Rails.groups)

module Mtlnewtech
  class Application < Rails::Application
    I18n.load_path += Dir[Rails.root.join('locales', '*.yml')]
    config.i18n.default_locale = :en
    config.i18n.enforce_available_locales = true
    config.i18n.available_locales = :en, :fr

    config.generators do |generate|
      generate.test_framework :rspec
      generate.helper false
      generate.javascript_engine false
      generate.stylesheets false
      generate.request_specs false
      generate.view_specs false
    end

    config.action_controller.action_on_unpermitted_parameters = :raise
    config.assets.quiet = true
    config.autoload_paths << Rails.root.join('lib')
  end
end
