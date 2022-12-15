class SessionsController < ApplicationController
  skip_before_action :authenticate_request, only: [:create]

  def create
    email = api_params[:email]
    password = api_params[:password]

    if email && password
      service_auth = Authenticate::User.call(email, password)

      if service_auth.success?
        login_hash = service_auth.result
        
        render json: { id: login_hash[:id], name: login_hash[:name], email: login_hash[:email], auth_token: login_hash[:accessToken] }
      else
        render json: { status: 'incorrect email or password' }, status: 403
      end
    else
      render json: { status: 'specify email address and password' }, status: 403
    end
  end

  private

  def api_params
    params.permit(:email, :password, :uuid, :origin, :fcmRegistrationId, :platform)
  end
end
