Rails.application.routes.draw do
  root "projects#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  #counter
  resources :tictacs, only: [:index]
  
  #project
  resources :projects do
    resources :tasks, except: [:index] do
      member do
        patch :drag
      end
    end
  end

  resources :tasks, only: [:new, :index] do
    resource :tictac, only: [:show]
  end


  #Api
  namespace :api do
    namespace :v1 do
      resources :tictacs, only: [] do
        collection do
          post :start
        end
        member do
          post :cancel
          post :finish
        end
      end
    end
  end
  
  #homepage
  resources :home, only: [:index]
  #chart
  resources :charts, only: [:index]
end
