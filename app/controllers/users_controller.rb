class UsersController < ApplicationController
  def show
    if current_user
      @user = User.find(current_user.id)
    else
      flash[:error] = "You must be logged in or registered to access your dashboard"
    end
  end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user.id)
    else
      flash[:error] = "Error: #{user.errors.full_messages.to_sentence}"
      redirect_to register_path
    end
  end

  def login_form
  end

  def login
    user = User.find_by(email: params[:email])
    if user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      # render :login_form
      flash[:error] = "Credentials invalid"
      redirect_to login_path
    end
  end

  def logout
    reset_session
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
