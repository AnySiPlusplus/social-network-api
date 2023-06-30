module Api
  module V1
    class NewslinesController < AuthentificateController
      def show
        result = Api::V1::Newsline::Show.call(current_user:, serializer: NewslineSerializer)
        default_handler(result)
      end
    end
  end
end
