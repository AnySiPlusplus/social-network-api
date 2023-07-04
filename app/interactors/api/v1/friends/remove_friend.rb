module Api
  module V1
    module Friends
      class RemoveFriend < BaseInteractor
        def call
          return not_found unless current_friend
          return access_denied unless belong_to_user?(Api::V1::FriendPolicy, current_friend)

          result
        end

        private

        def current_friend
          @current_friend ||= Friend.find_by(id: context.params[:id])
        end

        def result
          context.status = :no_content
          current_friend.destroy
        end
      end
    end
  end
end
