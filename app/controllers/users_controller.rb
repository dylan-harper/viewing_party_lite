class UsersController < ApplicationController
  def new
  end

  def discover
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.create!(name: user_params[:name], email: user_params[:email], password: user_params[:password], password_confirmation: user_params[:password_confirmation])
    redirect_to "/users/#{@user.id}"
  end

  private

  def user_params
    params.permit(:name, :email, :password, :password_confirmation)
  end

end
