# frozen_string_literal: true
source 'https://rubygems.org'

ruby '2.4.0'

gem 'pg'
gem 'puma', '~> 3.0'
gem 'rails', '>= 5.0.0.1'

# Assets
gem 'autoprefixer-rails'
gem 'bourbon'
gem 'jquery-rails'
gem 'neat'
gem 'sass-rails', '~> 5.0'
gem 'sprockets', '>= 3.0.0'
gem 'sprockets-commoner'
gem 'turbolinks', '~> 5'
gem 'uglifier', '>= 1.3.0'

# Internationalization
gem 'activemodel-serializers-xml'
gem 'globalize', git: 'https://github.com/globalize/globalize'
gem 'globalize-accessors'
gem 'route_translator'

# Image uploading
gem 'carrierwave'
gem 'cloudinary'

# Admin dashboard
gem 'administrate'
gem 'enumerize'
gem 'validate_url'

# Authentication
gem 'devise'

# Nice urls
gem 'friendly_id'

# Event import
gem 'google-api-client'

# Link parsing
gem 'rinku'

# Caching
gem 'dalli'
gem 'memcachier'

# Awesome debugging
gem 'awesome_print'
gem 'pry-rails'

# Sidekiq UI and test fakes
gem 'sinatra', '~> 2.0.0.beta2'

# Monitoring
gem 'bugsnag'
gem 'skylight'

group :development, :test do
  gem 'bullet'
  gem 'bundler-audit', '>= 0.5.0', require: false
  gem 'dotenv-rails'
  gem 'factory_girl_rails'
  gem 'faker'
  gem 'refills'
  gem 'rspec-rails', '~> 3.5'
end

group :development do
  gem 'listen'
  gem 'spring'
  gem 'spring-watcher-listen'
  gem 'web-console'
end

group :test do
  gem 'capybara'
  gem 'codecov', require: false
  gem 'database_cleaner'
  gem 'formulaic'
  gem 'launchy'
  gem 'poltergeist'
  gem 'rspec-its'
  gem 'shoulda-matchers'
  gem 'simplecov', require: false
  gem 'webmock'
end

group :production do
  gem 'rails_12factor'
end
