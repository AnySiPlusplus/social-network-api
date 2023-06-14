module Api
  module V1
    module Sessions
      class CreateSession < BaseInteractor
        def call
          return generate_access_token if context.context&.form

          user_not_exist unless current_user
          wrong_password unless authenticate
          generate_access_token
          context.success_message = { token: :generated }
          context.status = :ok
        end

        private

        def user_not_exist
          context.message = { login: I18n.t('session.errors.login') }
          context.fail!
        end

        def current_user
          @current_user ||= User.find_by(login: context.params[:user][:login])
        end

        def authenticate
          current_user.authenticate(context.params[:user][:password])
        end

        def wrong_password
          context.message = { password: I18n.t('session.errors.password') }
          context.fail!
        end

        def generate_access_token
          context.headers = ::Users::Token.new.generate(context.context&.form || current_user)
        end
      end
    end
  end
end
