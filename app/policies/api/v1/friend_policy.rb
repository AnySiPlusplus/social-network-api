module Api
  module V1
    class FriendPolicy < ApplicationPolicy
      def belong_to_user?
        @subject.friends.include?(@model)
      end
    end
  end
end
