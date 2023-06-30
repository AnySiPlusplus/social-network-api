module Api
  module V1
    class MessagesController < AuthentificateController
      def index
        result = Api::V1::Messages::Index.call(current_user:, serializer: MessageSerializer)
        default_handler(result)
      end

      def show
        result = Api::V1::Messages::Show.call(params:, current_user:, serializer: MessageSerializer)
        default_handler(result)
      end

      def update
        result = Api::V1::Messages::UpdateMessage.call(params:, current_user:, serializer: MessageSerializer)
        default_handler(result)
      end

      def create
        result = Api::V1::Messages::CreateMessage.call(params:, current_user:, serializer: MessageSerializer)
        default_handler(result)
      end

      def destroy
        result = Api::V1::Messages::DestroyMessage.call(params:, current_user:)
        default_handler(result)
      end
    end
  end
end
