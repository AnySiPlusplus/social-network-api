require 'shrine'
require 'shrine/storage/file_system'
require 'shrine/storage/memory'
require 'shrine/storage/s3'

s3_options = Rails.application.credentials.aws if Rails.env.production?

Shrine.storages = if Rails.env.test?
                    {
                      cache: Shrine::Storage::Memory.new,
                      store: Shrine::Storage::Memory.new
                    }
                  elsif Rails.env.development?
                    {
                      cache: Shrine::Storage::FileSystem.new('public', prefix: 'uploads/cache'),
                      store: Shrine::Storage::FileSystem.new('public', prefix: 'uploads')
                    }
                  else
                    {
                      cache: Shrine::Storage::S3.new(prefix: 'cache', **s3_options),
                      store: Shrine::Storage::S3.new(**s3_options)
                    }
                  end

Shrine.plugin :activerecord
Shrine.plugin :cached_attachment_data
Shrine.plugin :restore_cached_data
Shrine.plugin :validation
Shrine.plugin :validation_helpers
Shrine.plugin :determine_mime_type
