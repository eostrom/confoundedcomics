require 'test_helper'

class AdministratorTest < ActiveSupport::TestCase
  context 'An Administrator' do
    setup do
      @administrator = Factory.create(:administrator)
    end

    should('be valid') { assert @administrator.valid? }
  end
end
