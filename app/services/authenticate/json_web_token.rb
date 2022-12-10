class Authenticate::JsonWebToken
  class << self
    def encode(payload, exp = 30.days.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base, 'HS256')
    end

    def decode(token)
      JWT.decode(token, ENV['SECRET_KEY_BASE'] || Rails.application.secrets.secret_key_base, false, { algorithm: 'HS512' })[0]
    end
  end
end