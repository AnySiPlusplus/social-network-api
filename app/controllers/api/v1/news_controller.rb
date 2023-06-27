module Api
  module V1
    class NewsController < AuthentificateController
      def index
        result = Api::V1::News::Index.call(current_user:, serializer: NewsSerializer)
        default_handler(result)
      end

      def show
        result = Api::V1::News::Show.call(params:, current_user:, serializer: NewsSerializer)
        default_handler(result)
      end

      def create
        result = Api::V1::News::CreateNews.call(params:, current_user:, serializer: NewsSerializer)
        default_handler(result)
      end

      def update
        result = Api::V1::News::UpdateNews.call(params:, current_user:, serializer: NewsSerializer)
        default_handler(result)
      end

      def destroy
        result = Api::V1::News::DestroyNews.call(params:, current_user:)
        default_handler(result)
      end
    end
  end
end
