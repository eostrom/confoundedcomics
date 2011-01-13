# -*- ruby -*-

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
gem 'paperclip', '~> 2.3.8'
gem 'remotipart', '~> 0.2.0'
gem 'haml', '~> 3.0.16'
gem 'friendly_id', '~> 3.1.7'
gem 'formtastic', '~> 1.2.2'
gem 'chronic', '~> 0.3.0'

# gems used for both test and cucumber environments
def shared_testing_gems
  gem 'factory_girl_rails', '~> 1.0'
  gem 'faker', '~> 0.3.1'
end

group :test do
  gem 'shoulda', '~> 2.11.3'
  gem 'rr', '~> 1.0.2'
  gem 'timecop', '~> 0.3.5'
  shared_testing_gems
end

group :cucumber do
  gem 'cucumber-rails', '~> 0.3.2'
  gem 'database_cleaner', '~> 0.6.0'
  gem 'capybara', '~> 0.4.0'
  # gem 'capybara-envjs', '~> 0.4.0'
  # gem 'capybara-envjs-fixes', :git => 'git://github.com/rajatvig/capybara-envjs-fixes.git'
  # gem 'akephalos', :git => 'git://github.com/thoughtbot/akephalos.git'
  shared_testing_gems
end
