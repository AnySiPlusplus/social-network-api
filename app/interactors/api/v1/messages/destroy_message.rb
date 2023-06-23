module Api
  module V1
    module Messages
      class DestroyMessage < BaseInteractor
        def call
          return access_denied unless belong_to_user?

          result
        end

        private

        def current_message
          @current_message ||= Message.find(context.params[:id])
        end

        def result
          context.status = :no_content
          current_message.destroy
        end
      end
    end
  end
end
