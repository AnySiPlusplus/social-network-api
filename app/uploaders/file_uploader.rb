require 'image_processing/mini_magick'

class FileUploader < Shrine
  SIZE = 1..5 * 1024 * 1024
  TYPE = %w[image/jpeg image/png image/gif image/jpg].freeze
  EXTENSION = %w[jpeg png gif jpg].freeze

  Attacher.validate do
    validate_size SIZE
    validate_mime_type TYPE
    validate_extension EXTENSION
  end
end
