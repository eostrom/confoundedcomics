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
    scope = administrator_signed_in? ? Page : Page.published
    @page = scope.find(params[:id])
    @book = @page.book

    render :action => 'show'
  rescue ActiveRecord::RecordNotFound
    unless scope.empty?
      flash[:warning] =
        "Can't find the page you're looking for, but here's the latest!"
    end

    # TODO: don't just show a page from a random book!
    redirect_to(scope.latest || root_url)
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
