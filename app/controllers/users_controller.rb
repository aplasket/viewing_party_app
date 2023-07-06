class UsersController < ApplicationController
  def show; end

  def new
    @user = User.new
  end

  def create
    user = User.new(user_params)
    if user.save
      redirect_to user_path(user.id)
    else
      flash[:error] = "Error: #{user.errors.full_messages.to_sentence}"
      redirect_to register_path
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end
end
