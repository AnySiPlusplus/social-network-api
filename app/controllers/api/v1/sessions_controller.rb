module Api
  module V1
    class SessionsController < ApplicationController
      before_action :authorize_access_request!, only: :destroy

      def create
        result = Api::V1::Sessions::CreateSession.call(params:)
        default_handler(result)
      end

      def destroy
        result = Api::V1::Sessions::DestroySession.call(payload:)
        default_handler(result)
      end
    end
  end
end
