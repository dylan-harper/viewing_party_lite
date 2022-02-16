class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def discover
    @user = User.find(params[:id])
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    if User.invalid_length?(user_params[:password])#&& !user_params[:password_confirmation].invalid?
      flash[:error] = 'Invalid password, length must be greater than 8 characters'
      return redirect_to '/register'
    elsif User.invalid_characters?(user_params[:password]) #&& !user_params[:password_confirmation].invalid?
      flash[:error] = 'Invalid password, must only include numbers or letters'
      return redirect_to '/register'
    # elsif !user_params[:password] || !user_params[:password_confirmation]
    #   flash[:error] = 'Missing a password field or confirmation'
    #   return redirect_to '/register'
    elsif user_params[:password] != user_params[:password_confirmation]
      flash[:error] = 'Password and confirmation do not match'
      return redirect_to '/register'
    end

    user = user_params
    user[:email] = user[:email].downcase
    @user = User.create(user)

    if @user != nil
      flash[:success] = "Welcome, #{@user.name}!"
      redirect_to "/users/#{@user.id}"
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

end
