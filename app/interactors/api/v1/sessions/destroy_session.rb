module Api
  module V1
    module Sessions
      class DestroySession < BaseInteractor
        def call
          current_session.flush_by_access_payload
          context.status = :no_content
        end

        private

        def current_session
          JWTSessions::Session.new(payload: context.payload, refresh_by_access_allowed: true)
        end
      end
    end
  end
end
