class BooksController < ApplicationController
  def index
    @books = Book.published.descend_by_published_at
  end

  def show
    @book = Book.published.find(params[:id])

    redirect_to @book.pages.latest
  end
end
