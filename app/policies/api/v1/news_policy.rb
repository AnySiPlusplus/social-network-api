module Api
  module V1
    class NewsPolicy < ApplicationPolicy
      def belong_to_user?
        @subject.news.include?(@model)
      end
    end
  end
end
