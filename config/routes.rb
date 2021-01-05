Rails.application.routes.draw do
  root 'home#index'
  
  ActiveAdmin.routes(self)
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: [:index, :show]
    end
  end
end
