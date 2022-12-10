class ApplicationController < ActionController::API
  include ::ActionController::Cookies
  attr_reader :current_user

  before_action :authenticate_cookie

  # def current_ability
  #   UserAbility.new(@current_user) if @current_user
  # end

  private

  def authenticate_cookie
    token = Rails.env.development? ? cookies.signed[:"next-auth.session-token"] : get_cookie_prod
    p "TOKEN"
    p token
    decoded_token = Authenticate::JsonWebToken.decode(token)
    p "DECODE"
    p decoded_token
    if decoded_token && decoded_token["sub"]
      @current_user = User.find_by_id(decoded_token["sub"])
    end

    if @current_user then return true else render json: { status: 'unauthorized', code: 401 }, status: :unauthorized end
  end

  def get_cookie_prod
    cookies[:"next-auth.session-token"] || cookies[:"__Secure-next-auth.session-token"]
  end
end
