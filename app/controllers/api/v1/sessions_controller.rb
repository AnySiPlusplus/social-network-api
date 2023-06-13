module Api
  module V1
    class SessionsController < ApplicationController
      def create
        result = Api::V1::Sessions::CreateSession.call(params:)
        default_handler(result)
      end
    end
  end
end
