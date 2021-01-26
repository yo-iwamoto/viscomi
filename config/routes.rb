Rails.application.routes.draw do
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      get '/com_names'         => 'community_centers#names'
      get '/community_center'  => 'community_centers#show'
      get '/timeline'          => 'timelines#show'
      post '/post_image/:id'   => 'posts#image'
      resources :users,               only: %i[index show create update destroy]
      resources :sessions,            only: %i[create destroy]
      resources :account_activations, only: %i[edit]
      resources :community_centers,   only: %i[index create update destroy]
      resources :posts,               only: %i[index show create update destroy]
      resources :ads,                 only: %i[create]
    end
  end
  get '*path', to: 'home#index'
  
end
