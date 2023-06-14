module Api::V1
  class UserForm < BaseForm
    MINIMUM_USER_NAME_LENGTH = 3
    MAXIMUM_USER_NAME_LENGTH = 50
    MINIMUM_PASSWORD_LENGTH = 8
    FORMAT_PASSWORD = /\A[A-Za-z0-9_-]*\z/

    properties :login, :password
    property :password_confirmation, virtual: true

    validation do
      params do
        required(:login).filled(:string, min_size?: MINIMUM_USER_NAME_LENGTH, max_size?: MAXIMUM_USER_NAME_LENGTH)
        required(:password).filled(:string, min_size?: MINIMUM_PASSWORD_LENGTH)
        required(:password_confirmation).filled(:string)
      end

      rule(:password_confirmation, :password) do
        key.failure(I18n.t('user.errors.password_confirmation')) if values[:password_confirmation] != values[:password]
      end

      rule(:login) do
        key.failure(I18n.t('user.errors.login')) if User.find_by(login: values[:login])
      end

      rule(:password) do
        key.failure(I18n.t('user.errors.password')) unless FORMAT_PASSWORD.match?(values[:password])
      end
    end
  end
end
