module Api
  module V1
    module Newsline
      class Show < BaseInteractor
        def call
          context.status = :ok
        end
      end
    end
  end
end
