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

  def bad_outcome
    context.message = current_form.errors.messages
    context.fail!
  end

  def belong_to_user?(policy_class, model)
    policy_class.new(model, context.current_user).belong_to_user?
  end
end
