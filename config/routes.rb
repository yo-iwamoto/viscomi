Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      get '/com_names'         => 'community_centers#names'
      post '/ad_image/'        => 'ads#image'
      post '/post_image/:id'   => 'posts#image'
      resources :users,               only: %i[index show create update destroy]
      resources :sessions,            only: %i[create destroy]
      resources :account_activations, only: %i[edit]
      resources :community_centers,   only: %i[index show create update destroy]
      resources :posts,               only: %i[index show create update destroy]
      resources :ads,                 only: %i[create]
      resources :timelines,           only: %i[index]
    end
  end
  get '*path', to: 'home#index'
  
end
