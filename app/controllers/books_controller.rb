class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

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

  def edit
    @edit = Book.find(params[:id])
  end

  def update
    @update = Book.find(params[:id])
    @update.update(book_params)
    redirect_to book_path(@update.id)
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

  def is_matching_login_user
    book = Book.find(params[:id])
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
