class BaseInteractor
  include Interactor

  def access_denied
    context.message = { access: :denied }
    context.status = :forbidden
    context.fail!
  end

  def belong_to_user?
    Api::V1::MessagePolicy.new(current_message, context.current_user).belong_to_user?
  end
end
