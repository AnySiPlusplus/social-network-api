Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api do
    namespace :v1 do
      resource :session, only: %i[create destroy]

      resources :users, only: :create
      resources :messages
      resources :news
      resource :newsline, only: :show
    end
  end
end
