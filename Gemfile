source 'https://rubygems.org'

gem 'rails', '4.1.8'
gem 'bootstrap-sass', '3.1.1.0'

group :development do
  # Use sqlite3 as the database for Active Record
  gem 'sqlite3'
  gem 'annotate'
end

group :assets do
  # Use SCSS for stylesheets
  gem 'sass-rails', '~> 4.0.3'
  # Use Uglifier as compressor for JavaScript assets
  gem 'uglifier', '>= 1.3.0'
  # Use CoffeeScript for .js.coffee assets and views
  gem 'coffee-rails', '~> 4.0.0'
end

group :test, :development do
  gem 'rspec-rails'
  gem 'guard-rspec'
  gem 'guard-spork'
  gem 'spork'
end

group :test do
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
end

group :production do
  gem 'pg'
end
# Use jquery as the JavaScript library
gem 'jquery-rails'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'
# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0',          group: :doc

# Use ActiveModel has_secure_password
gem 'bcrypt', '~> 3.1.7'
gem 'bcrypt-ruby', '3.0.1'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin]
