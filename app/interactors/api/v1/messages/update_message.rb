module Api
  module V1
    module Messages
      class UpdateMessage < BaseInteractor
        def call
          return not_found unless current_message
          return access_denied unless belong_to_user?

          current_form.validate(permit_params) ? good_outcome : bad_outcome
        end

        private

        def good_outcome
          current_form.save
          context.form = current_form.model
          context.success_message = { operation: :success }
          context.status = :ok
        end

        def bad_outcome
          context.message = current_form.errors.messages
          context.fail!
        end

        def current_message
          @current_message ||= Message.find(context.params[:id])
        end

        def current_form
          @current_form ||= Api::V1::MessageForm.new(current_message)
        end

        def permit_params
          @permit_params ||= context.params.require(:message).permit(:text, :file)
        end
      end
    end
  end
end
