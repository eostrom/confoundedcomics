class BooksController < ApplicationController
  before_filter :authenticate_administrator!, :except => [:index, :show]

  def index
    @books = Book.published.descend_by_published_at
  end

  def show
    @book = Book.published.find(params[:id])

    redirect_to @book.pages.latest
  end

  def new
    @book = Book.new(params[:book])
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to new_page_path(:book_id => @book)
    else
      render :action => 'new'
    end
  end
end
