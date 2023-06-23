module Api
  module V1
    class MessageForm < BaseForm
      MINIMUM_MESSAGE_LENGTH = 10
      MAXIMUM_MESSAGE_LENGTH = 256

      property :text
      property :file
      property :to_whom

      validation do
        params do
          required(:text).filled(:string, min_size?: MINIMUM_MESSAGE_LENGTH,
                                          max_size?: MAXIMUM_MESSAGE_LENGTH)

          required(:to_whom)
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
