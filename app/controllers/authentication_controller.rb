class AuthenticationController < ApplicationController
  skip_before_action :authorize_user, only: :authenticate  
  # return auth token once user is authenticated
  def authenticate
    auth_token =
      AuthenticateUser.new(auth_params[:username]).call
      json_response(auth_token: auth_token, message: Message.logged_in)
  end

  private

  def auth_params
    params.permit(:username)
  end
end