ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class Test::Unit::TestCase
  include RR::Adapters::TestUnit
end

class ActiveSupport::TestCase
  def login_as(user)
    user = Factory.create(user) if Symbol === user
    @controller.session ||= {}
    @controller.send(:current_user=, user)
  end
end

class ActionController::TestCase
  include Devise::TestHelpers
end
