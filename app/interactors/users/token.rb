module Users
  class Token
    def generate(user)
      session = JWTSessions::Session.new(payload: { user_id: user.id }, refresh_by_access_allowed: true)
      { JWTSessions.access_header => session.login[:access] }
    end
  end
end
