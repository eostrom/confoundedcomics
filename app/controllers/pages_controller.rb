class PagesController < ApplicationController
  def index
    @book = Book.find(params[:book_id])
    @pages = @book.pages.find(:all,
      :order => 'published_at DESC', :limit => 10)

    respond_to do |format|
      format.atom { @updated = @book.pages.maximum(:updated_at) }
    end
  end

  def show
    @page = params[:id] ? Page.published.find(params[:id]) : Page.latest
    @book = @page.book

    render :show
  end
end
