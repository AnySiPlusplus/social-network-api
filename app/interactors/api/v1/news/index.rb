module Api
  module V1
    module News
      class Index < BaseInteractor
        def call
          context.form = context.current_user.news
          context.success_message = { operation: :success }
          context.status = :ok
        end
      end
    end
  end
end
