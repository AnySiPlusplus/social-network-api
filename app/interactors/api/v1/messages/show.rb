module Api
  module V1
    module Messages
      class Show < BaseInteractor
        def call
          return not_found unless current_message
          return access_denied unless belong_to_user?

          result
        end

        private

        def current_message
          @current_message ||= Message.find_by(id: context.params[:id])
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
