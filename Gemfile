source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
  gem 'rails', '4.0.0'

# WEB SERVER
  gem 'unicorn'

# DATABASE
  gem "pg"

# DEBUGGER
  gem "pry-rails"
  group :development do
    gem "better_errors"
    gem "binding_of_caller"
  end

# ASSETS :CONFIGURATION
  gem 'sass-rails', '~> 4.0.0'
  gem 'uglifier', '>= 1.3.0'
  gem 'coffee-rails', '~> 4.0.0'
  gem "haml-rails"

# ASSETS :FEATURES
  gem 'jquery-rails'
  gem 'underscore-rails'
  gem 'turbolinks'
  gem 'jquery-turbolinks'
  gem "zurb-foundation", "~> 4.0.0"

# TESTING
  group :development, :test do
    gem "rspec-rails"
    gem "guard-rspec"
  end

  group :test do
    gem "factory_girl_rails"
    gem "shoulda-context"
    gem "shoulda-matchers"
  end

# WEB SCRAPING
  gem "watir-webdriver"
  gem "nokogiri"

# API BUILDER
  gem "active_model_serializers"

# DEPLOYMENT
  gem 'rails_12factor', group: :production

# ======================================
# OTHER THINGS THAT I DONT WANT TO TOUCH
# ======================================

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 1.2'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.0.0'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]
