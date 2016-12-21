# frozen_string_literal: true
Rails.application.configure do
  config.action_controller.perform_caching = false
  config.action_mailer.default charset: 'utf-8'
  config.action_mailer.default_url_options = { host: 'localhost:3000' }
  config.action_mailer.perform_caching = false
  config.action_mailer.preview_path = "#{Rails.root}/spec/mailers/previews"
  config.action_mailer.raise_delivery_errors = false
  config.action_view.raise_on_missing_translations = true
  config.active_record.migration_error = :page_load
  config.active_support.deprecation = :log
  config.assets.debug = true
  config.assets.digest = true
  config.assets.quiet = true
  config.assets.raise_runtime_errors = true
  config.cache_classes = false
  config.cache_store = :null_store
  config.consider_all_requests_local = true
  config.eager_load = false
  config.file_watcher = ActiveSupport::EventedFileUpdateChecker
end
