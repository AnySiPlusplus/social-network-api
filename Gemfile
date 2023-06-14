source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby File.read('.ruby-version').split.join

gem 'action_policy'
gem 'acts_as_list'
gem 'aws-sdk-s3', '~> 1.114'
gem 'bcrypt-ruby'
gem 'bootsnap', require: false
gem 'dotenv-rails'
gem 'dry-validation', '~> 1.5'
gem 'factory_bot_rails'
gem 'ffaker'
gem 'image_processing'
gem 'interactor', '~> 3.0'
gem 'jsonapi-serializer'
gem 'jwt_sessions'
gem 'pg', '~> 1.1'
gem 'puma', '~> 5.0'
gem 'rack-cors'
gem 'rails', '~> 7.0.3', '>= 7.0.3.1'
gem 'redis', '~> 4.7', '>= 4.7.1'
gem 'reform-rails'
gem 'rswag'
gem 'shrine', '~> 3.4'
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]

group :development, :test do
  gem 'bullet'
  gem 'pry-byebug'
end

group :production, :development, :test do
  gem 'rspec-rails', '6.0.0.rc1'
end

group :test do
  gem 'json_matchers'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers', '~> 5.0'
  gem 'simplecov', require: false
  gem 'trailblazer-endpoint', github: 'trailblazer/trailblazer-endpoint'
end

group :development do
  gem 'brakeman', require: false
  gem 'bundle-audit', require: false
  gem 'fasterer', require: false
  gem 'lefthook', require: false
  gem 'rubocop', require: false
  gem 'rubocop-i18n', require: false
  gem 'rubocop-performance', require: false
  gem 'rubocop-rails', require: false
  gem 'rubocop-rspec', require: false
end
