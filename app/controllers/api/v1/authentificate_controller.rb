module Api
  module V1
    class AuthentificateController < ApplicationController
      include JWTSessions::Authorization
      before_action :authorize_access_request!

      def current_user
        @current_user ||= ::User.find(payload['user_id'])
      end
    end
  end
end
