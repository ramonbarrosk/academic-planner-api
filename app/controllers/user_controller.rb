class UserController < ApplicationController
  skip_before_action :authenticate_cookie, only: [:create]

  def create
    @user = User.new(user_params)

    if @user.save 
      render json: @user, status: 201
    else 
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password)
  end
end
