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
      @book = Factory.create(:book,
        :banner_file_name => 'banner.jpg',
        :published_at => 2.days.ago, :title => 'A Book')
      @page = Factory.create(:page,
        :published_at => 2.days.ago, :book => @book)

      @params = { :book_id => @book.to_param, :id => @page.to_param }
      @action = lambda { get :show, @params }
    end

    context '' do
      setup { @action.call }

      should render_template(:show)
      should assign_to(:page).with(@page)

      # should 'include the book title in the title element' do
      #   assert_select('title', 'A Book - Confounded Contraption')
      # end
    end

    context 'given multiple pages' do
      setup do
        @first = Factory.create(:page, :title => 'Page 1',
          :published_at => 3.days.ago, :book => @book)
        @last = Factory.create(:page, :title => 'Page 3',
          :published_at => 1.day.ago, :book => @book)
        @action.call
      end

      should 'link between them' do
        assert_select 'a[href=?]', book_page_path(@book, @first), 'First'
        assert_select 'a[href=?]', book_page_path(@book, @first), 'Previous'
        assert_select 'a[href=?]', book_page_path(@book, @last), 'Next'
        assert_select 'a[href=?]', book_page_path(@book, @last), 'Last'
        assert_select 'a[href=?]', book_page_path(@book, @first), 'Page 1'
        assert_select 'a[href=?]', book_page_path(@book, @last), 'Page 3'
      end

      context '(some unpublished)' do
        setup { @last.update_attributes(:published_at => 1.day.from_now) }

        context '(signed in)' do
          setup { sign_in Factory.create(:administrator); @action.call }

          should 'link to unpublished pages' do
            assert_select('#banner a[href=?]', book_page_path(@book, @last))
            assert_select 'li.published a', 'First'
            assert_select 'li.published a', 'Previous'
            assert_select 'li.unpublished a', 'Next'
            assert_select 'li.unpublished a', 'Last'
            assert_select 'li.published a', 'Page 1'
            assert_select 'li.unpublished a', 'Page 3'
          end
        end

        context '(signed out)' do
          setup { sign_out :administrator; @action.call }

          should 'not link to unpublished pages' do
            assert_select('#banner a[href=?]', book_page_path(@book, @page))
            assert_select 'a[href=?]', book_page_path(@book, @last), false
          end
        end
      end
    end

    context '(signed in)' do
      setup { sign_in Factory.create(:administrator) }

      should 'show a new page link' do
        @action.call
        assert_select 'a[href=?]', new_book_page_path(@book), 'New page'
      end
    end

    context '(signed out)' do
      setup { sign_out :administrator }

      should 'not show a new page link' do
        @action.call
        assert_select 'a[href=?]', new_book_page_path(@book), false
      end
    end

    context 'an unpublished page' do
      setup { @page.update_attributes!(:published_at => 1.day.from_now) }

      context 'to an administrator' do
        setup do
          sign_in Factory.create(:administrator)

          @action.call
        end

        should render_template(:show)
      end

      context 'to the general public' do
        setup do
          @latest = Factory.create(:page,
            :published_at => 1.day.ago, :book => @book)

          @action.call
        end

        should redirect_to('the latest page') { [@book, @latest] }
      end
    end

    context 'a page from an unpublished book' do
      setup do
        @book.update_attributes!(:published_at => 1.day.from_now)
      end

      context 'to an administrator' do
        setup do
          sign_in Factory.create(:administrator)
          @action.call
        end

        should render_template(:show)
      end

      context 'to the general public' do
        setup { @action.call }

        should redirect_to('the home page') { root_path }
      end
    end
  end

  context 'new' do
    setup do
      @book = Factory.create(:book)
      @params = { :book_id => @book.id }
      @action = lambda { get :new, @params }
    end

    context '(signed in)' do
      setup do
        sign_in Factory.create(:administrator)
        @action.call
      end

      should respond_with(:success)
      should render_template(:new)
    end
  end

  context 'create' do
    setup do
      @book = Factory.create(:book)

      sign_in Factory.create(:administrator)

      @params = { :book_id => @book.id, :page => Factory.attributes_for(:page)}
      @action = lambda { post :create, @params }
    end

    context 'with valid params' do
      setup { @action.call }

      should assign_to(:page).with_kind_of(Page)
      should 'save the page' do
        assert_equal 1, Page.count
      end
      should redirect_to('the page') { [assigns[:page].book, assigns[:page]] }
    end

    context 'with invalid params' do
      setup { @params[:page] = {}; @action.call }

      should assign_to(:page).with_kind_of(Page)
      should 'not save the page' do
        assert_equal 0, Page.count
      end
      should render_template(:new)
    end
  end

  context 'edit' do
    setup do
      @page = Factory.create(:page)
      @params = { :book_id => @page.book.to_param, :id => @page.to_param }
      @referer =
        @request.env['HTTP_REFERER'] = book_page_path(@page.book, @page)
      @action = lambda { get :edit, @params }
    end

    context '(signed in)' do
      setup do
        sign_in Factory.create(:administrator)
        @action.call
      end

      should respond_with(:success)
      should assign_to(:page).with(@page)
      should render_template(:edit)

      should 'have a cancel link' do
        assert_select 'a[href=?]', @referer, 'Cancel'
      end
    end
  end

  context 'update' do
    setup do
      @page = Factory.create(:page)

      sign_in Factory.create(:administrator)

      @params = { :book_id => @page.book.to_param, :id => @page.to_param }
      @action = lambda { put :update, @params }
    end

    context 'with valid params' do
      setup do
        @params[:page] = { :title => 'New Title' }
        @action.call
      end

      should assign_to(:page).with(@page)

      should('update the page') do
        assert_equal 'New Title', Page.find(@page.id).title
      end

      # can't use @page here because the URL changed with the title...
      should redirect_to('the page') { [@page.book, assigns[:page]] }
    end

    context 'with invalid params' do
      setup do
        @params[:page] = { :comic_file_name => nil }
        @action.call
      end

      should assign_to(:page).with

      should('not update the page') do
        assert_equal @page.comic_file_name, Page.find(@page.id).comic_file_name
      end

      should render_template(:edit)
    end
  end

  context 'delete' do
    setup do
      @page = Factory.create(:page)

      sign_in Factory.create(:administrator)

      delete :destroy, :book_id => @page.book.to_param, :id => @page.to_param
    end

    should('destroy the page') { assert !Page.find_by_id(@page) }
    should redirect_to('the book') { book_path(@page.book) }
  end

  context 'page_path' do
    setup do
      @book = Factory.create(:book, :title => 'Book 1')
      @page = Factory.create(:page, :title => 'Page 1',
        :published_at => '2010-08-08', :book => @book)
    end

    should 'generate a book-and-page URL' do
      assert_equal('/books/book-1/pages/2010-08-08-page-1',
        book_page_path(@book, @page))

      assert_recognizes(
        {
          :controller => 'pages',
          :action => 'show',
          :book_id => 'book-1',
          :id => @page.to_param
        },
        '/books/book-1/pages/2010-08-08-page-1')
    end
  end
end
