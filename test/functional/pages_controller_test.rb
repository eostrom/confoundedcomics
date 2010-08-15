require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  context 'index' do
    setup do
      @book = Factory.create(:book, :title => 'A Book')
      @page = Factory.create(:page,
        :published_at => '2010-08-08', :book => @book)

      @params = {:book_id => @book.id}
      @action = lambda { get :index, @params }
    end

    should 'have an atom feed' do
      @params[:format] = 'atom'
      @action.call

      assert_select 'feed[xmlns=?]', 'http://www.w3.org/2005/Atom'
      assert_select('entry', 1) do
        assert_select('published',
          @page.published_at.to_time(:local).to_datetime.to_s)
      end
    end
  end

  context 'show' do
    setup do
      @book = Factory.create(:book, :title => 'A Book')
      @page1 = Factory.create(:page,
        :published_at => 2.days.ago, :book => @book)
      @page2 = Factory.create(:page,
        :published_at => 1.day.ago, :book => @book)

      @params = {}
      @action = lambda { get :show, @params }
    end

    should 'include the book title in the title element' do
      @action.call

      assert_select('title', 'A Book - Confounded Contraption')
    end

    context 'given no page ID' do
      setup do
        @action.call
      end

      it { should assign_to(:page).with(@page2) }
    end

    context 'given a page ID' do
      setup do
        @params[:id] = @page1.id
        @action.call
      end

      it { should assign_to(:page).with(@page1) }
    end
  end

  context 'page_path' do
    setup do
      @book = Factory.create(:book, :title => 'Book 1')
      @page = Factory.create(:page, :title => 'Page 1',
        :published_at => '2010-08-08', :book => @book)
    end

    should 'generate a book-and-page URL' do
      assert_equal '/pages/book-1:2010-08-08:page-1', page_path(@page)
      assert_recognizes(
        {
          :controller => 'pages',
          :action => 'show',
          :id => @page.to_param
        },
        '/pages/book-1:2010-08-08:page-1')
    end
  end
end
