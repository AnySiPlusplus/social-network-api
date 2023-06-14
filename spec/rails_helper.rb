require 'simplecov_helper'
require 'spec_helper'
require 'json_matchers/rspec'
require 'shoulda/matchers'
require_relative 'support/helpers/application_helper'

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'

abort(_('The Rails environment is running in production mode!')) if Rails.env.production?
require 'rspec/rails'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end

JsonMatchers.schema_root = 'spec/support/api/schemas'

RSpec.configure do |config|
  config.fixture_path = Rails.root.join('/spec/fixtures')
  config.include ApplicationHelper
  config.include FactoryBot::Syntax::Methods
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!
  config.filter_rails_from_backtrace!
end
