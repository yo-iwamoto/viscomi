Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
      resources :sessions, only: %i[create destroy]
    end
  end
  resources :account_activations, only: %i[edit]

  get '*path', to: 'home#index'
end
