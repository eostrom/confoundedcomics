require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActiveSupport::TestCase
  context 'An untitled Book' do
    setup { @book = Factory.build(:book, :title => nil) }

    should('have no style') { assert !@book.style }
  end
end
