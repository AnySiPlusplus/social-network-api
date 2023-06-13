class ApplicationController < ActionController::API
  include JWTSessions::RailsAuthorization
  include HandleStatusCode
  rescue_from JWTSessions::Errors::Unauthorized, with: :not_authorized

  private

  def not_authorized
    render json: { error: I18n.t('session.errors.not_autorized') }, status: :unauthorized
  end
end
