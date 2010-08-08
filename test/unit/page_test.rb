require File.dirname(__FILE__) + '/../test_helper'

class PageTest < ActiveSupport::TestCase
  context 'A saved Page' do
    setup { @page = Factory.create(:page) }

    context 'published in the past' do
      setup { @page.update_attribute(:published_at, 1.day.ago) }
      should('be in .published') { assert Page.published.include?(@page) }
    end

    context 'published in the future' do
      setup { @page.update_attribute(:published_at, 1.day.from_now) }
      should('not be in .published') { assert !Page.published.include?(@page) }
    end

    context 'with no publish date' do
      setup { @page.update_attribute(:published_at, nil) }
      should('not be in .published') { assert !Page.published.include?(@page) }
    end
  end
end
