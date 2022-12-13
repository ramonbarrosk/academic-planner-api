class ApplicationController < ActionController::API
  attr_reader :current_user

  before_action :authenticate_request

  # def current_ability
  #   UserAbility.new(@current_user) if @current_user
  # end

  private

  def authenticate_request
    @current_user = ::AuthorizeApiRequest.call(request.headers).result
    render json: { error: 'Not Authorized' }, status: 401 unless @current_user
  end
end
