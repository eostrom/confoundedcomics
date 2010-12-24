class BooksController < ApplicationController
  before_filter :authenticate_administrator!, :except => [:index, :show]

  def index
    @books = Book.published.descend_by_published_at
  end

  def show
    @book = Book.published.find(params[:id])
    scope = administrator_signed_in? ? @book.pages : @book.pages.published

    redirect_to [@book, scope.latest]
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
