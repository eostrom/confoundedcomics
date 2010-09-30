ENV["RAILS_ENV"] = "test"
require File.expand_path(File.dirname(__FILE__) + "/../config/environment")
require 'test_help'

class ActiveSupport::TestCase
  def login_as(user)
    user = Factory.create(user) if Symbol === user
    @controller.session ||= {}
    @controller.send(:current_user=, user)
  end
end
