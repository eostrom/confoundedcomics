source 'http://rubygems.org'

gem 'rails', '3.0.3'

# Bundle edge Rails instead:
# gem 'rails', :git => 'git://github.com/rails/rails.git'

gem 'mysql2'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug'

# Bundle the extra gems:
# gem 'bj'
# gem 'nokogiri'
# gem 'sqlite3-ruby', :require => 'sqlite3'
# gem 'aws-s3', :require => 'aws/s3'

# Bundle gems for the local environment. Make sure to
# put test-only gems in this group so their generators
# and rake tasks are available in development mode:
# group :development, :test do
#   gem 'webrat'
# end
gem "hobo_fields", ">= 1.3.0.pre23"

gem 'devise', '~> 1.1.5'

# comics stuff
gem 'paperclip', '~> 2.3.3'
gem 'haml', '~> 3.0.16'
gem 'friendly_id', '~> 3.1.7'
gem 'formtastic', '~> 1.2.2'

# TODO: extract gems shared by test and cucumber

group :test do
  gem 'shoulda', '~> 2.11.3'
  gem 'factory_girl_rails', '~> 1.0'
  gem 'faker', '~> 0.3.1'
end

group :cucumber do
  gem 'cucumber-rails', '~> 0.3.2'
  gem 'database_cleaner', '~> 0.5.2'
  gem 'capybara', '~> 0.3.9'
  gem 'factory_girl_rails', '~> 1.0'
  gem 'faker', '~> 0.3.1'
end
