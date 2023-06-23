require 'swagger_helper'

RSpec.describe 'Messages', type: :request do
  describe 'Messages' do
    let!(:user) { create(:user) }
    let(:Authorization) { "Bearer #{generate_token(user)}" }

    path '/api/v1/messages' do
      post 'Creates a message' do
        tags 'Message'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          properties: {
            message: { type: :object,
                       properties: {
                         text: { type: :string },
                         file: { type: :file },
                         to_whom: { type: :string }
                       } }
          },

          required: %w[text file to_whom]
        }

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '201', 'Message created' do
          let(:params) { attributes_for(:message).except(:user) }

          run_test! do
            expect(response).to match_json_schema('message_create')
          end
        end

        response '422', 'unprocessable entity' do
          let(:params) { { text: '', to_whom: user.id } }

          run_test! do
            expect(response).to match_json_schema('message_wrong_params')
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

      get 'index messages' do
        tags 'Message'
        produces 'application/json'
        consumes 'application/json'

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '200', 'index message' do
          let(:message) { create(:message, user_id: user.id) }

          run_test! do
            expect(response).to match_json_schema('message_index')
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

    path '/api/v1/messages/{id}' do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      delete 'delete message' do
        tags 'Message'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '204', 'delete message' do
          let(:message) { create(:message, user_id: user.id) }
          let(:id) { message.id }

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
          let(:id) { create(:message, user_id: create(:user).id).id }

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

      put 'update message' do
        tags 'Message'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        parameter name: :params, in: :body, schema: {
          properties: {
            message: { type: :object,
                       properties: {
                         text: { type: :string },
                         file: { type: :file },
                         to_whom: { type: :string }
                       } }
          },

          required: %w[text file to_whom]
        }

        response '200', 'update message' do
          let!(:message) { create(:message, user_id: user.id) }
          let(:params) { attributes_for(:message).except(:user) }
          let(:id) { message.id }

          run_test! do
            expect(response).to match_json_schema('message_update')
          end
        end

        response '403', 'forbidden' do
          let(:params) { 'test params' }
          let(:id) { create(:message, user_id: create(:user).id).id }

          run_test! do
            expect(response).to match_json_schema('user_forbidden')
          end
        end

        response '401', 'un authorized' do
          let(:Authorization) { 'no token' }
          let(:params) { 'test' }
          let(:id) { 0 }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end

        response '422', 'unprocessed entity' do
          let!(:message) { create(:message, user_id: user.id) }
          let(:params) { { text: nil } }
          let(:id) { message.id }

          run_test!
        end

        response '404', 'not found' do
          let!(:message) { create(:message, user_id: user.id) }
          let(:params) { { title: message.text } }
          let(:id) { 0 }

          run_test! do
            expect(response).to match_json_schema('not_found')
          end
        end
      end

      get 'show message' do
        tags 'Message'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'show project' do
          let(:id) { create(:message, user_id: user.id).id }

          run_test! do
            expect(response).to match_json_schema('message_show')
          end
        end

        response '401', 'not aurhorized' do
          let(:Authorization) { 'no token' }
          let(:id) { 0 }

          run_test! do
            expect(response).to match_json_schema('session_not_authorized')
          end
        end

        response '403', 'forbidden' do
          let(:id) { create(:message, user_id: create(:user).id).id }

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
