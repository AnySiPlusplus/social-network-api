require 'swagger_helper'

RSpec.describe 'Friends', type: :request do
  describe 'Friends' do
    let!(:user) { create(:user) }
    let(:Authorization) { "Bearer #{generate_token(user)}" }

    path '/api/v1/friends' do
      post 'Add friend' do
        tags 'Friend'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          properties: {
            user_id: { type: :string }
          },

          required: %w[user_id]
        }

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '201', 'Friend added' do
          let(:params) { { user_id: create(:user).id } }

          run_test! do
            expect(response).to match_json_schema('friend_added')
          end
        end

        response '404', 'not found' do
          let(:params) { { user_id: 0 } }

          run_test! do
            expect(response).to match_json_schema('not_found')
          end
        end

        response '401', 'not aurhorized' do
          let(:Authorization) { 'no token' }
          let(:params) { 'params' }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end
      end

      get 'index friends' do
        tags 'Friend'
        produces 'application/json'
        consumes 'application/json'

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '200', 'index friends' do
          let(:friend) { create(:user_friend, user_id: user.id) }

          run_test! do
            expect(response).to match_json_schema('friend_index')
          end
        end

        response '401', 'not aurhorized' do
          let(:Authorization) { 'no token' }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end
      end
    end

    path '/api/v1/friends/{id}' do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      delete 'remove friend' do
        tags 'Friend'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '204', 'remove friend' do
          let(:user_friend) { create(:user_friend, user_id: user.id) }
          let(:id) { user_friend.friend.id }

          run_test!
        end

        response '401', 'un authorized' do
          let(:Authorization) { 'no token' }
          let(:id) { 0 }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end

        response '403', 'forbidden' do
          let(:id) { create(:user_friend, user_id: create(:user).id).friend.id }

          run_test! do
            expect(response).to match_json_schema('user_forbidden')
          end
        end

        response '404', 'not found' do
          let(:id) { 0 }

          run_test! do
            expect(response).to match_json_schema('not_found')
          end
        end
      end
    end
  end
end
