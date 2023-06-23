module Api
  module V1
    module Messages
      class Show < BaseInteractor
        def call
          return access_denied unless belong_to_user?
          return not_found unless current_message

          result
        end

        private

        def current_message
          @current_message ||= Message.find_by(id: context.params[:id])
        end

        def not_found
          context.staus = :not_found
          context.message = { message: :not_found }
          context.fail!
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
