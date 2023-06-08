class BooksController < ApplicationController
  def index
    @post = Book.new
    @books = Book.all
  end

  def create
    @post = Book.new(book_params)
    @post.user_id = current_user.id
    @post.save
    redirect_to book_path(@post.id)
  end

  def show
    @post = Book.new
    @book = Book.find(params[:id])
  end

  def destroy
    delete = Book.find(params[:id])
    delete.destroy
    redirect_to books_path
  end

  private
  def book_params
    params.require(:book).permit(:title, :body)
  end
end
