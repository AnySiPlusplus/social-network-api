require 'simplecov'

SimpleCov.start 'rails' do
  add_filter '/app/models'
  add_filter '/app/jobs'
  add_filter '/app/mailers'

  minimum_coverage(100)
end
