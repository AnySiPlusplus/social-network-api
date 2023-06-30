module Api
  module V1
    module News
      class Show < BaseInteractor
        def call
          return not_found unless current_news
          return access_denied unless belong_to_user?(Api::V1::NewsPolicy, current_news)

          result
        end

        private

        def current_news
          @current_news ||= ::News.find_by(id: context.params[:id])
        end

        def result
          context.status = :ok
          context.success_message = { operation: :success }
          context.form = current_news
        end
      end
    end
  end
end
