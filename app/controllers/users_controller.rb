class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:toppage, :about]
  def toppage
  end

def about
end

  def index
      @users = User.all
      @user = current_user
      @book =Book.new
  end

  def show
      @user = User.find(params[:id])
      @book = Book.new
      @books = @user.books
  end

  def edit
  	  @user = User.find(params[:id])
  	  if @user != current_user
         redirect_to user_path(current_user)
     end
  end

  def update
      @user = User.find(params[:id])
      		if
			@user.update(user_params)
			flash[:notice] = "user was successfully updated."
			redirect_to user_path
		else
			render 'users/edit'
		end
  end

  private

	def user_params
		params.require(:user).permit(:name, :profile_image, :introduction )
	end

end
