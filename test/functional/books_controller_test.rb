require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  context 'index' do
    setup do
      @published = Factory.create(:book, :title => 'A Book',
        :published_at => 2.days.ago)
      @unpublished = Factory.create(:book, :title => 'A New Book',
        :published_at => 2.days.from_now)

      get :index
    end

    should 'list the published books' do
      assert_select('li a[href=?]', book_path(@published), 'A Book')
      assert_select('li a[href=?]', book_path(@unpublished), false)
    end
  end

  context 'show' do
    setup do
      @book = Factory.create(:book, :title => 'A Book',
        :published_at => 2.days.ago)
      @page = Factory.create(:page, :book => @book,
        :published_at => 2.days.ago)
      Factory.create(:page, :book => @book,
        :published_at => 2.days.from_now)
      Factory.create(:page, :book => @book)

      get :show, :id => @book.id
    end

    should redirect_to('the latest published page') { @page }
  end
end
