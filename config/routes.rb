Rails.application.routes.draw do
  root 'home#index'
  
  ActiveAdmin.routes(self)
  
  namespace :api, { format: 'json' } do
    namespace :v1 do
      resources :users, only: %i[index show create update destroy]
    end
  end

  get '*path', to: 'home#index'
end
