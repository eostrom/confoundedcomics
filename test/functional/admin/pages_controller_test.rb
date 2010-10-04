require File.dirname(__FILE__) + '/../../test_helper'

class Admin::PagesControllerTest < ActionController::TestCase
  context 'index' do
    setup do
      login_as :admin_user

      @action = lambda { get :index }
    end

    context 'given an untitled page' do
      setup do
        @untitled = Factory.create(:page, :title => '')
        @action.call
      end

      should 'link to [untitled]' do
        assert_select('.page-link[href=?]',
          admin_page_path(@untitled), '[untitled]')
      end
    end
  end
end
