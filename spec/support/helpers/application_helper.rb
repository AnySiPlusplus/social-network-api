module ApplicationHelper
  def generate_token(user)
    JWTSessions::Session.new(payload: { user_id: user.id }, refresh_by_access_allowed: true).login[:access]
  end
end
