Rails.application.routes.draw do
  root 'home#index'
  
  ActiveAdmin.routes(self)
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      post 'sample' => 'users#sample'
      resources :users, only: %i[index show new create edit update destroy]
    end
  end

  get '*path', to: 'home#index'
end
