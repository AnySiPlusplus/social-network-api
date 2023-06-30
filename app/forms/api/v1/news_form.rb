module Api
  module V1
    class NewsForm < BaseForm
      MINIMUM_NEWS_LENGTH = 1
      MAXIMUM_NEWS_LENGTH = 256

      property :content
      property :file

      validation do
        params do
          required(:content).filled(:string, min_size?: MINIMUM_NEWS_LENGTH,
                                             max_size?: MAXIMUM_NEWS_LENGTH)
          required(:file)
        end

        rule(:file) do
          attacher = FileUploader::Attacher.new
          attacher.assign(value)
          attacher.errors.each { |error| key.failure(error) }
          value&.open
        end
      end
    end
  end
end
