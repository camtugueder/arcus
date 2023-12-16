source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.6.5'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.5'
# Use sqlite3 as the database for Active Record
gem 'sqlite3'
# Use Puma as the app server
gem 'puma', '~> 3.11'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# Use ActiveModel has_secure_password
 gem 'bcrypt', '~> 3.1.7'

# Generate fake data
gem 'faker', '2.13'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem 'factory_bot_rails', '6.1.0'
  gem 'rspec-rails', '4.0.1'
  # Dotenv gem for managing environment variables
  gem 'dotenv-rails'
end


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 3.3.0'
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'activerecord-import'
  gem 'bullet'
end

group :test do
  gem 'rspec-json_expectations', '~> 2.2'
  gem 'simplecov', require: false
  gem 'webmock', '3.8.3'
  gem 'shoulda-matchers', '~> 4.0'
end
# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

gem 'kaminari'

gem 'devise'
gem 'devise-jwt'
gem 'rolify'
gem 'pundit'