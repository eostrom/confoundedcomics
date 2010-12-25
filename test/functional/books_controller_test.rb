require 'test_helper'

class BooksControllerTest < ActionController::TestCase
  context 'index' do
    setup do
      @published = Factory.create(:book, :title => 'A Book',
        :published_at => 2.days.ago)
      @unpublished = Factory.create(:book, :title => 'A New Book',
        :published_at => 2.days.from_now)

      @action = lambda { get :index }
    end

    should 'list the published books' do
      @action.call

      assert_select('li a[href=?]', book_path(@published), 'A Book')
      assert_select('li a[href=?]', book_path(@unpublished), false)
    end

    # test the layout....
    context '(signed in)' do
      setup { sign_in Factory.create(:administrator); @action.call }

      should 'have administrator controls' do
        assert @response.body =~ /admin/i
        assert_select 'a[href=?]', new_book_path, 'New book'
        assert_select('a[href=?]',
          destroy_administrator_session_path, 'Sign out')
      end
    end

    context '(signed out)' do
      setup { sign_out :administrator; @action.call }

      should 'not have administrator controls' do
        assert !(@response.body =~ /admin/i)
        assert_select 'a[href=?]', new_book_path, false
      end
    end
  end

  context 'show' do
    setup do
      @book = Factory.create(:book, :title => 'A Book',
        :published_at => 2.days.ago)
      @published = Factory.create(:page, :book => @book,
        :published_at => 2.days.ago)
      @unpublished = Factory.create(:page, :book => @book,
        :published_at => 2.days.from_now)
      Factory.create(:page, :book => @book)

      @params = {:id => @book.id}
      @action = lambda { get :show, @params }
    end

    context '(signed in)' do
      setup { sign_in Factory.create(:administrator); @action.call }
      # should redirect_to('the latest page') { @unpublished }
    end

    context '(signed out)' do
      setup { sign_out :administrator; @action.call }
      should redirect_to('the latest published page') { [@book, @published] }
    end
  end

  context 'new' do
    setup { @action = lambda { get :new } }

    context '(signed in)' do
      setup do
        sign_in Factory.create(:administrator)
        @action.call
      end

      should respond_with(:success)
      should render_template(:new)
    end

    context '(signed out)' do
      setup do
        sign_out :administrator
        @action.call
      end

      should redirect_to('the login page') { new_administrator_session_url }
      should set_the_flash.to(/sign in/i)
    end
  end

  context 'create' do
    setup do
      sign_in Factory.create(:administrator)

      @params = {:book => Factory.attributes_for(:book)}
      @action = lambda { post :create, @params }
    end

    context 'with valid params' do
      setup { @action.call }

      should assign_to(:book).with_kind_of(Book)
      should redirect_to('the new page form') {
        new_book_page_url(assigns[:book])
      }
    end

    context 'with invalid params' do
      setup { @params[:book] = {}; @action.call }

      should assign_to(:book).with(nil)
      should render_template(:new)
    end
  end
end
