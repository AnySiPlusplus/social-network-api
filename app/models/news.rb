class News < ApplicationRecord
  include FileUploader::Attachment(:file)

  belongs_to :user
end
