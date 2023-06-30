module Api
  module V1
    module News
      class CreateNews < BaseInteractor
        def call
          current_form.validate(permit_params) ? good_outcome : bad_outcome
        end

        private

        def good_outcome
          current_form.save
          context.form = current_form.model
          context.success_message = { message: :created }
          context.status = :created
        end

        def current_form
          @current_form ||= Api::V1::NewsForm.new(context.current_user.news.build)
        end

        def permit_params
          @permit_params ||= context.params.require(:news).permit(:content, :file)
        end
      end
    end
  end
end
