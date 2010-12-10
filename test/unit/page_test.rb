require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context 'A saved Page' do
    setup do
      @page = Factory.create(:page)
      @other_page =
        Factory.create(:page, :title => 'Another Page', :book => @page.book)
      @other_book_page = Factory.create(:page, :title => 'Another Book Page')
    end

    context 'published in the past' do
      setup do
        @page.update_attribute(:published_at, 3.days.ago)
      end

      should('be in .published') { assert Page.published.include?(@page) }

      should('possibly have a previous page') do
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 5.days.ago)
        assert_equal @other_page, @page.previous
        @other_book_page.update_attribute(:published_at, 4.days.ago)
        assert_equal @other_page, @page.previous
      end

      should('possibly have a next page') do
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.ago)
        @other_book_page.update_attribute(:published_at, 2.day.ago)
        assert_equal @other_page, @page.next
        @other_page.update_attribute(:published_at, 5.days.ago)
        assert !@page.next
      end
    end

    context 'published in the future' do
      setup { @page.update_attribute(:published_at, 2.days.from_now) }

      should('not be in .published') { assert !Page.published.include?(@page) }

      should('have the last published page as its previous page') do
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert_equal @other_page, @page.previous
      end

      should('not have a next page') do
        assert !@page.next
        @other_page.update_attribute(:published_at, 3.days.from_now)
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert !@page.next
      end
    end

    context 'with no publish date' do
      setup { @page.update_attribute(:published_at, nil) }

      should('not be in .published') { assert !Page.published.include?(@page) }

      should('not have a previous page') do
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert !@page.previous
      end

      should('not have a next page') do
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert !@page.next
      end
    end
  end

  context 'A Page' do
    setup do
      @page = Factory.create(:page,
        :published_at => '2010-08-08', :title => 'A Page',
        :book => Factory.create(:book, :title => 'A Book'))
    end

    should 'have a book:date:title permalink' do
      assert_equal 'a-book:2010-08-08:a-page', @page.to_param
    end

    context 'with no title' do
      setup do
        @page.update_attributes(:title => nil)
      end

      should 'have a book:date permalink' do
        assert_equal 'a-book:2010-08-08', @page.to_param
      end
    end
  end
end
