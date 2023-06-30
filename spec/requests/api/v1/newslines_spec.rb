require 'swagger_helper'

RSpec.describe 'Newsline', type: :request do
  describe 'News' do
    let!(:user) { create(:user) }
    let(:Authorization) { "Bearer #{generate_token(user)}" }

    path '/api/v1/newsline' do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })
      get 'show newsline' do
        tags 'Newsline'
        consumes 'application/json'
        produces 'application/json'

        response '200', 'show project' do
          run_test!
        end

        response '401', 'not aurhorized' do
          let(:Authorization) { 'no token' }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end
      end
    end
  end
end
