module Api
  module V1
    module Messages
      class Show < BaseInteractor
        def call
          return access_denied unless belong_to_user?

          result
        end

        private

        def current_message
          @current_message ||= Message.find(context.params[:id])
        end

        def result
          context.status = :ok
          context.success_message = { operation: :success }
          context.form = current_message
        end
      end
    end
  end
end
