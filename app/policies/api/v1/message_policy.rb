module Api
  module V1
    class MessagePolicy < ApplicationPolicy
      def belong_to_user?
        @subject.messages.include?(@model)
      end
    end
  end
end
