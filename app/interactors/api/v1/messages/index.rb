module Api
  module V1
    module Messages
      class Index < BaseInteractor
        def call
          context.form = context.current_user.messages
          context.success_message = { operation: :success }
          context.status = :ok
        end
      end
    end
  end
end
