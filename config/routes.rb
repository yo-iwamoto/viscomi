Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users,               only: %i[index show create update destroy]
      resources :sessions,            only: %i[create]
      resources :account_activations, only: %i[edit]
      resources :community_centers,   only: %i[index show create update destroy]
      resources :posts,               only: %i[index show create update destroy]
      get '/community_centers/names' => 'community_centers#names'
    end
  end

  get '*path', to: 'home#index'
end
