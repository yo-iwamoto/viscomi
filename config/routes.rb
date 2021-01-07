Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
      resources :sessions, only: %i[create destroy]
      resources :account_activations, only: %i[edit]
    end
  end

  get '*path', to: 'home#index'
end
