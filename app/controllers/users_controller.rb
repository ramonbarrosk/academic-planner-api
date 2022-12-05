class UsersController < ApplicationController
  skip_before_action :authenticate_cookie, only: [:create]
  before_action :find_user, only: [:show]

  def create
    @user = User.new(user_params)

    if @user.save 
      render json: @user, status: 201
    else 
      render json: { errors: @user.errors.full_messages }, status: 503
    end
  end

  def show
    render json: @user, status: 200
  end

  private

  def find_user
    @user = User.find_by(id: params[:id])
  end

  def user_params
    params.permit(:name, :email, :password)
  end
end
