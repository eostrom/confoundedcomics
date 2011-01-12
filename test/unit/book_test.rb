require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActiveSupport::TestCase
  context 'A Book' do
    setup { @book = Factory.build(:book) }

    should 'accept natural-language publish dates' do
      Timecop.freeze do
        @book.published_at_string = 'today'
        assert_equal Date.today, @book.published_at
      end
    end
  end

  context 'An untitled Book' do
    setup { @book = Factory.build(:book, :title => nil) }

    should('have no style') { assert !@book.style }
  end

  context 'A published Book' do
    setup { @book = Factory.create(:book, :published_at => 1.day.ago) }

    should 'be visible to everyone' do
      admin = Factory.create(:administrator)
      assert @book.visible_to(admin)
      assert Book.visible_to(admin).find(@book)
      assert @book.visible_to(nil)
      assert Book.visible_to(nil).include? @book
    end
  end

  context 'An unpublished Book' do
    setup { @book = Factory.create(:book, :published_at => 1.day.from_now) }

    should 'be visible only to administrators' do
      admin = Factory.create(:administrator)
      assert @book.visible_to(admin)
      assert Book.visible_to(admin).find(@book)
      assert !@book.visible_to(nil)
      assert !(Book.visible_to(nil).include? @book)
    end
  end
end
