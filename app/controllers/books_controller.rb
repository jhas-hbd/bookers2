class BooksController < ApplicationController
  before_action :is_matching_login_user, only: [:edit, :update]

  def index
    @post = Book.new
    @books = Book.all
    @user = current_user
  end

  def create
    @books = Book.all
    @user = current_user
    @post = Book.new(book_params)
    @post.user_id = current_user.id
    if @post.save
      flash[:notice] = "You have created book successfully."
      redirect_to book_path(@post.id)
    else
      render :index
    end
  end

  def show
    @post = Book.new
    @book = Book.find(params[:id])
    @user = @book.user
  end

  def edit
    @update = Book.find(params[:id])
  end

  def update
    @update = Book.find(params[:id])
    if @update.update(book_params)
      flash[:notice] = "You have updaated book successfully."
      redirect_to book_path(@update.id)
    else
      render :edit
    end
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
    puts book.user_id
    puts current_user.id
    unless book.user_id == current_user.id
      redirect_to books_path
    end
  end
end
