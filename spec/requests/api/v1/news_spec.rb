require 'swagger_helper'

RSpec.describe 'News', type: :request do
  describe 'News' do
    let!(:user) { create(:user) }
    let(:Authorization) { "Bearer #{generate_token(user)}" }

    path '/api/v1/news' do
      post 'Creates a news' do
        tags 'News'
        produces 'application/json'
        consumes 'application/json'
        parameter name: :params, in: :body, schema: {
          properties: {
            news: { type: :object,
                    properties: {
                      content: { type: :string },
                      file: { type: :file }
                    } }
          },

          required: %w[text file]
        }

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '201', 'News created' do
          let(:params) { attributes_for(:news).except(:user) }

          run_test! do
            expect(response).to match_json_schema('news_create')
          end
        end

        response '422', 'unprocessable entity' do
          let(:params) { { context: '' } }

          run_test! do
            expect(response).to match_json_schema('news_wrong_params')
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

      get 'index news' do
        tags 'News'
        produces 'application/json'
        consumes 'application/json'

        parameter({
                    in: :header,
                    type: :string,
                    name: :Authorization,
                    required: true,
                    description: 'Client token'
                  })

        response '200', 'index news' do
          let(:news) { create(:news, user_id: user.id) }

          run_test! do
            expect(response).to match_json_schema('news_index')
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

    path '/api/v1/news/{id}' do
      parameter({
                  in: :header,
                  type: :string,
                  name: :Authorization,
                  required: true,
                  description: 'Client token'
                })

      delete 'delete news' do
        tags 'News'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '204', 'delete news' do
          let(:news) { create(:news, user_id: user.id) }
          let(:id) { news.id }

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
          let(:id) { create(:news, user_id: create(:user).id).id }

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

      put 'update news' do
        tags 'News'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        parameter name: :params, in: :body, schema: {
          properties: {
            news: { type: :object,
                    properties: {
                      text: { type: :string },
                      file: { type: :file }
                    } }
          },

          required: %w[text file]
        }

        response '200', 'update news' do
          let!(:news) { create(:news, user_id: user.id) }
          let(:params) { attributes_for(:news).except(:user) }
          let(:id) { news.id }

          run_test! do
            expect(response).to match_json_schema('news_update')
          end
        end

        response '403', 'forbidden' do
          let(:params) { 'test params' }
          let(:id) { create(:news, user_id: create(:user).id).id }

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
          let!(:news) { create(:news, user:) }
          let(:params) { { content: nil } }
          let(:id) { news.id }

          run_test!
        end

        response '404', 'not found' do
          let(:id) { 0 }
          let(:params) { {} }

          run_test! do
            expect(response).to match_json_schema('not_found')
          end
        end
      end

      get 'show news' do
        tags 'News'
        consumes 'application/json'
        produces 'application/json'
        parameter name: :id, in: :path, type: :string

        response '200', 'show project' do
          let(:id) { create(:news, user_id: user.id).id }

          run_test! do
            expect(response).to match_json_schema('news_show')
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
          let(:id) { create(:news, user_id: create(:user).id).id }

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
