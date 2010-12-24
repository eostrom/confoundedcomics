class BooksController < ApplicationController
  before_filter :authenticate_administrator!, :except => [:index, :show]

  def index
    @books = Book.published.descend_by_published_at
  end

  def show
    @book = Book.visible_to(current_administrator).find(params[:id])
    @page = @book.pages.visible_to(current_administrator).latest

    redirect_to [@book, @page]
  rescue ActiveRecord::RecordNotFound
    "Can't find the book you're looking for. Try these books instead!"
    redirect_to(root_url)
  end

  def new
    @book = Book.new(params[:book])
  end

  def create
    @book = Book.new(params[:book])
    if @book.save
      redirect_to new_book_page_path(@book)
    else
      render :action => 'new'
    end
  end
end
