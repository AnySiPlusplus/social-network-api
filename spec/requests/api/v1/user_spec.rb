require 'swagger_helper'

RSpec.describe 'Users', type: :request do
  describe 'Users' do
    path '/api/v1/users' do
      post 'Creates a user' do
        tags 'User'
        operationId 'TestUser'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          properties: {
            user: { type: :object,
                    properties: {
                      login: { type: :string },
                      password: { type: :string },
                      password_confirmation: { type: :string }
                    } }
          },
          required: %w[login password password_confirmation]
        }

        response '201', 'user created' do
          let(:params) do
            { user: { login: 'user1@gmail.com', password: 'Password1', password_confirmation: 'Password1' } }
          end

          run_test! do
            expect(response).to match_json_schema('user')
          end
        end

        response '422', 'wrong login params' do
          let(:params) { { user: { login: '1', password: '1', password_confirmation: '2' } } }

          run_test! do
            expect(response).to match_json_schema('user_wrong_params')
          end
        end
      end
    end
  end
end
