class ApplicationController < ActionController::API
    include Response
    include ExceptionHandler
  
    # called before every action on controllers
    before_action :authorize_user
    attr_reader :current_user
  
    private
  
    # Check for valid request token and return user
    def authorize_user
      @current_user = (AuthorizeApiRequest.new(request.headers).call)[:user]
    end
end
