module Api
  module V1
    class FriendsController < AuthentificateController
      def index
        result = Api::V1::Friends::Index.call(current_user:, serializer: FriendSerializer)
        default_handler(result)
      end

      def create
        result = Api::V1::Friends::AddFriend.call(params:, current_user:, serializer: FriendSerializer)
        default_handler(result)
      end

      def destroy
        result = Api::V1::Friends::RemoveFriend.call(params:, current_user:)
        default_handler(result)
      end
    end
  end
end
