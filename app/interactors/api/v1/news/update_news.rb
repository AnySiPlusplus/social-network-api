module Api
  module V1
    module News
      class UpdateNews < BaseInteractor
        def call
          return not_found unless current_news
          return access_denied unless belong_to_user?(Api::V1::NewsPolicy, current_news)

          current_form.validate(permit_params) ? good_outcome : bad_outcome
        end

        private

        def good_outcome
          current_form.save
          context.form = current_form.model
          context.success_message = { operation: :success }
          context.status = :ok
        end

        def current_form
          @current_form ||= Api::V1::NewsForm.new(current_news)
        end

        def current_news
          @current_news ||= ::News.find_by(id: context.params[:id])
        end

        def permit_params
          context.params.require(:news).permit(:content, :file)
        end
      end
    end
  end
end
