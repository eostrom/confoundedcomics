require File.dirname(__FILE__) + '/../test_helper'

class PublishableTest < ActiveSupport::TestCase
  class Testable < ActiveRecord::Base
    set_table_name 'pages'
    include Publishable
  end

  context 'A Publishable' do
    setup do
      @publishable = Testable.new
    end

    should('be valid') { assert @publishable.valid? }

    context 'with a malformed date string' do
      setup { @publishable.published_at_string = 'asdaeae33' }

      should 'be invalid' do
        assert !@publishable.valid?
        assert @publishable.errors[:published_at_string]
      end
    end
  end
end
