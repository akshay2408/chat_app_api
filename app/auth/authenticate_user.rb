class AuthenticateUser
  def initialize(username)
    @username = username
  end

  # Service entry point
  def call
    JsonWebToken.encode(user_id: user.id) if user
  end

  private

  attr_reader :username

  # verify user credentials
  def user
    user = User.find_by(username: username)
    return user if user
    # raise Authentication error if credentials are invalid
    raise(ExceptionHandler::AuthenticationError, Message.invalid_credentials)
  end
end