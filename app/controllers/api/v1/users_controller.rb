module Api
  module V1
    class UsersController < ApplicationController
      def create
        result = Api::V1::Users::CreateUser.call(params:, serializer: NewUserSerializer)
        default_handler(result)
      end
    end
  end
end
