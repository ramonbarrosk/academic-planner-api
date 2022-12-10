class Authenticate::JsonWebToken
  class << self
    def encode(payload, exp = 30.days.from_now)
      payload[:exp] = exp.to_i
      p "---"
      p payload
      JWT.encode payload, nil, 'none'
    end

    def decode(token)
      p "---"
      p token
      decode = JWT.decode token, nil, false
      decode[0]
    rescue
      nil
    end
  end
end