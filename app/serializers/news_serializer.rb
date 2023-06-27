class NewsSerializer < ApplicationSerializer
  attributes :content, :file, :created_at, :updated_at
end
