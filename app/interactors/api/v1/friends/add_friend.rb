module Api
  module V1
    module Friends
      class AddFriend < BaseInteractor
        def call
          return not_found unless current_friend
          return good_outcome if friend_excist?

          current_form.save
          result
        end

        private

        def good_outcome
          context.status = :ok
          context.success_message = { friend: :already_added }
        end

        def friend_excist?
          context.current_user.friends.each do |friend|
            return true if friend.user == current_friend
          end

          false
        end

        def current_form
          @current_form ||= UserFriend.new(user_id: context.current_user.id, friend_id: friend_form.id)
        end

        def current_friend
          @current_friend ||= User.find_by(id: context.params[:user_id])
        end

        def friend_form
          @friend_form ||= Friend.create(user_id: current_friend.id)
        end

        def result
          context.form = current_form
          context.status = :created
          context.success_message = { friend: :added }
        end
      end
    end
  end
end
