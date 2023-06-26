class BaseInteractor
  include Interactor

  def access_denied
    context.message = { access: :denied }
    context.status = :forbidden
    context.fail!
  end

  def not_found
    context.status = :not_found
    context.message = { message: :not_found }
    context.fail!
  end

  def belong_to_user?
    Api::V1::MessagePolicy.new(current_message, context.current_user).belong_to_user?
  end
end
