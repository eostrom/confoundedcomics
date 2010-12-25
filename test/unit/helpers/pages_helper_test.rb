require 'test_helper'

class PagesHelperTest < ActionView::TestCase
  context 'published_state' do
    setup { @page = Factory.build(:page) }

    should 'be published if the page is published' do
      stub(@page).published? { true }
      assert_equal 'published', published_state(@page).to_s
    end

    should 'be unpublished if the page is not published' do
      stub(@page).published? { false }
      assert_equal 'unpublished', published_state(@page).to_s
    end
  end
end
