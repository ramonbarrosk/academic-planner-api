class Authenticate::JsonWebToken
  class << self
    def encode(payload, exp = 30.days.from_now)
      payload[:exp] = exp.to_i
      JWT.encode(payload, 'secret')
    end

    def decode(token)
      JWT.decode(token, 'secret', true, algorithm: 'HS256')[0]
    rescue
      nil
    end
  end
end