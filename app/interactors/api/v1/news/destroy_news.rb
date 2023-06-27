module Api
  module V1
    module News
      class DestroyNews < BaseInteractor
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
          context.status = :no_content
          current_news.destroy
        end
      end
    end
  end
end
