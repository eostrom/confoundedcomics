require File.dirname(__FILE__) + '/../test_helper'

class BookTest < ActiveSupport::TestCase
  context 'Book' do
    context '.published.descend_by_published_at' do
      setup do
        @published = Factory.create(:book, :published_at => 2.days.ago)
        @unpublished = Factory.create(:book, :published_at => 2.days.from_now)
        @unscheduled = Factory.create(:book, :published_at => nil)

        @result = Book.published.descend_by_published_at.to_a
      end

      should 'include published books' do
        assert @result.include?(@published)
      end

      should 'not include books to be published' do
        assert !@result.include?(@unpublished)
      end

      should 'not include unscheduled books' do
        assert !@result.include?(@unscheduled)
      end
    end
  end

  context 'An untitled Book' do
    setup { @book = Factory.build(:book, :title => nil) }

    should('have no style') { assert !@book.style }
  end
end
