class PagesController < ApplicationController
  before_filter :authenticate_administrator!, :except => [:index, :show]

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

  def new
    @book = Book.find(params[:book_id])
    @page = @book.pages.build(params[:page])
  end

  def create
    @book = Book.find(params[:book_id])
    @page = @book.pages.build(params[:page])

    if @page.save
      redirect_to page_path(@page)
    else
      render :action => 'new'
    end
  end
end
