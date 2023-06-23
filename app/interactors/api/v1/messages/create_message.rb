module Api
  module V1
    module Messages
      class CreateMessage < BaseInteractor
        def call
          return context.fail! unless to_whom_to_send

          current_form.validate(permit_params) ? good_outcome : bad_outcome
        end

        private

        def good_outcome
          current_form.save
          context.form = current_form.model
          context.success_message = { message: :created }
          context.status = :created
        end

        def bad_outcome
          context.message = current_form.errors.messages
          context.fail!
        end

        def current_form
          @current_form ||= Api::V1::MessageForm.new(Message.new(user: context.current_user))
        end

        def to_whom_to_send
          User.find(permit_params[:to_whom])
        end

        def permit_params
          @permit_params ||= context.params.require(:message).permit(:text, :to_whom, :file)
        end
      end
    end
  end
end
