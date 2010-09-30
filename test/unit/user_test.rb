require File.dirname(__FILE__) + '/../test_helper'

class UserTest < ActiveSupport::TestCase
  context 'A User' do
    setup { @user = Factory.build(:user) }

    should('be valid') { assert_valid @user }
  end

  context 'An Admin User' do
    setup { @user = Factory.build(:admin_user) }

    should('be valid') { assert_valid @user }
    should('be an administrator') { assert @user.administrator? }
  end
end
