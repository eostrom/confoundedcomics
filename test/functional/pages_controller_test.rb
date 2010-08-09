require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  context 'show' do
    setup do
      @page1 = Factory.create(:page, :published_at => 2.days.ago)
      @page2 = Factory.create(:page, :published_at => 1.day.ago)

      @params = {}
      @action = lambda { get :show, @params }
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
end
