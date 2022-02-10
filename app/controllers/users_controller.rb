class UsersController < ApplicationController
  #rescue_from ActiveRecord::RecordNotFound, with: :redirect_to_homepage
  
  def new
    @user = User.new
  end
  
  def create 
    @user = User.new(user_params)
    if @user.save
      flash[:success] = "Welcome to the Sample App!"
      redirect_to @user
    else
      render 'new'
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  protected
  
  def redirect_to_homepage
  redirect_to :root, alert: 'User not found'
  end
  
  private 
  
  def user_params
    params.require(:user).permit(:name, :email, :role, :password,
                                 :password_confirmation)
  end
end
