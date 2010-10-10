ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  def login_as(user)
    user = Factory.create(user) if Symbol === user
    @controller.session ||= {}
    @controller.send(:current_user=, user)
  end
end
