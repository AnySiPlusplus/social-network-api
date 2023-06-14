require 'swagger_helper'

RSpec.describe 'Sessions', type: :request do
  describe 'Sessions' do
    path '/api/v1/session' do
      post 'Creates a session' do
        tags 'Session'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          properties: {
            user: { type: :object,
                    properties: {
                      login: { type: :string },
                      password: { type: :string }
                    } }
          },
          required: %w[login password]
        }

        response '200', 'session created' do
          let!(:user) { create(:user) }
          let(:params) { { user: { login: user.login, password: user.password } } }

          run_test!
        end
      end

      delete 'delete session' do
        tags 'Session'
        consumes 'application/json'
        produces 'application/json'
        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true
                  })

        response '204', 'delete session' do
          let!(:user) { create(:user) }
          let(:Authorization) { "Bearer #{generate_token(user)}" }

          run_test!
        end

        response '401', 'not authorized' do
          let(:Authorization) { 'no token' }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end
      end
    end
  end
end
