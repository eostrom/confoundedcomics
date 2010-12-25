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
    @book = Book.visible_to(current_administrator).find(params[:book_id])
    # For friendly_id to work, we need to use Page and :scope, rather
    # than @book.pages.
    @page = Page.visible_to(current_administrator).
      find(params[:id], :scope => @book)

    render :action => 'show'
  rescue ActiveRecord::RecordNotFound
    if @book && @book.pages.visible_to(current_administrator).present?
      flash[:warning] =
        "Can't find the page you're looking for, but here's the latest!"
      redirect_to [@book, @book.pages.visible_to(current_administrator).latest]
    else
      flash[:warning] =
        "Can't find the page you're looking for. Try these books instead!"
      redirect_to(root_url)
    end
  end

  def new
    @book = Book.find(params[:book_id])
    @page = @book.pages.build(params[:page])
  end

  def create
    @book = Book.find(params[:book_id])
    @page = @book.pages.build(params[:page])

    if @page.save
      redirect_to [@book, @page]
    else
      render :action => 'new'
    end
  end
end
