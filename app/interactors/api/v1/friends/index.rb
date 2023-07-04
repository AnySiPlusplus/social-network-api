module Api
  module V1
    module Friends
      class Index < BaseInteractor
        def call
          context.form = context.current_user.friends
          context.status = :ok
          context.success_message = { operation: :success }
        end
      end
    end
  end
end
