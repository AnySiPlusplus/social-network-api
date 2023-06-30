class MessageSerializer < ApplicationSerializer
  attributes :text, :file, :to_whom, :created_at, :updated_at
end
