require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context 'A saved Page' do
    setup do
      @page = Factory.create(:page)
      @other_page = Factory.create(:page, :title => 'Another Page')
    end

    context 'published in the past' do
      setup { @page.update_attribute(:published_at, 2.day.ago) }

      should('be in .published') { assert Page.published.include?(@page) }

      should('possibly have a previous page') do
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert !@page.previous
        @other_page.update_attribute(:published_at, 3.days.ago)
        assert_equal @other_page, @page.previous
      end

      should('possibly have a next page') do
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.from_now)
        assert !@page.next
        @other_page.update_attribute(:published_at, 1.day.ago)
        assert_equal @other_page, @page.next
        @other_page.update_attribute(:published_at, 3.days.ago)
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
end
