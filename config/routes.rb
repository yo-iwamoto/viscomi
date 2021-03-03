Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root 'home#index'
  
  namespace :api, { format: 'json' } do
    namespace :v1 do

      get  '/com_names'              => 'community_centers#names'
      post '/ad_image/'              => 'ads#image'
      post '/post_image/:id'         => 'posts#image'
      post '/community_center_image' => 'community_centers#image'
      post '/contacts/image'         => 'contacts#image'
      post '/contacts/send'          => 'contacts#mail'

      resources :account_activations, only: %i[edit]
      resources :ads,                 only: %i[index create]
      resources :community_centers,   only: %i[index show create update destroy]
      resources :contacts,            only: %i[index show create update destroy]
      resources :posts,               only: %i[index show create update destroy]
      resources :sessions,            only: %i[create]
      resources :timelines,           only: %i[index]
      resources :users,               only: %i[index show create update destroy]
      resources :password_resets,     only: %i[create edit update]
      resources :feedbacks,           only: %i[create]
      resources :notifications,       only: %i[show update]
    end
  end

  if Rails.env == 'development'
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end
  get '*path', to: 'home#index'
  
end
