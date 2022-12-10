class Authenticate::User
  prepend SimpleCommand

  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    user = query_user

    return unless user

    {
      id: user.id,
      accessToken: Authenticate::JsonWebToken.encode(sub: user.id),
      name: user.name,
      email: user.email
    }
  end

  private

  def query_user
    user = User.find_by_email(@email) 

    return errors.add(:user_authentication, 'invalid credentials', { email: @email }) unless user && user.authenticate(@password)

    user
  end
end
