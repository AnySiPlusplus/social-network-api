# Base class for application policies
class ApplicationPolicy
  def initialize(model, subject)
    @model = model
    @subject = subject
  end
end
