module Api
  module V1
    module Users
      class CreateUser < BaseInteractor
        def call
          current_form.validate(permit_params) ? good_outcome : bad_outcome
        end

        private

        def good_outcome
          current_form.save
          context.form = User.find_by(login: current_form.login)
          context.status = :created
          context.success_message = { success_message: I18n.t('user.success_messages.registration') }
          generate_access_token
        end

        def generate_access_token
          result = Api::V1::Sessions::CreateSession.call(context:)
          context.headers = result.headers
        end

        def current_form
          @current_form ||= Api::V1::UserForm.new(User.new)
        end

        def permit_params
          context.params.require(:user).permit(:login, :password, :password_confirmation)
        end
      end
    end
  end
end
