class BooksController < ApplicationController
  before_action :authenticate_user!
  def new
      @book = Book.new
  end

  def create
      @book = Book.new(book_params)
      @book.user_id = current_user.id
      if @book.save
	  flash[:notice] = "Book was successfully created."
	  redirect_to books_path
	  else
	  @books = Book.all
	  @user = current_user
	  render 'books/index'
	  end
  end

  def index
   	  @books = Book.all
  	  @book = Book.new
  	  @user = current_user
  end

  def show
      @book = Book.find(params[:id])
      @user = @book.user
      @books = Book.new
  end


  def edit
  	  @book = Book.find(params[:id])
  	  if @book.user != current_user
  	  	redirect_to books_path
  	  end
  end

  def destroy
  	@book =Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path(@book.id)
  end

  def update
  	@book = Book.find(params[:id])
  	if @book.update(book_params)
  	flash[:notice] = "Book was successfully updated."
  	redirect_to book_path(@book)
  	else
  	render "edit"
  	end
  end

  private

	def book_params
		params.require(:book).permit(:title, :body)
	end
end
