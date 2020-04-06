class UsersController < ApplicationController

  before_action :ensure_current_user, only: [:edit, :update]

  def ensure_current_user
    if user_signed_in?
      user = User.find(params[:id])
      if current_user.id !=  user.id
        redirect_to user_path(current_user)
      end
    end
  end


  def index
    if user_signed_in?
    	@users = User.all
    	@user = User.find(current_user.id)
    	@book = Book.new
    else
      redirect_to new_user_session_path
    end
  end

  def show
    if user_signed_in?
    	@user = User.find(params[:id])
      @books = @user.books
    	@book = Book.new
    else
      redirect_to new_user_session_path
    end
  end

  def edit
    if user_signed_in?
  	 @user = User.find(params[:id])
    else
      redirect_to new_user_session_path
    end
  end

  def update
  	@user= User.find(params[:id])
  	if @user.update(user_params)
  	   redirect_to user_path(@user.id), notice: 'You have updated user successfully.'
    else
       render action: :edit
    end
  end

  private

  def user_params
  	params.require(:user).permit(:name, :profile_image, :introduction)
  end

end
