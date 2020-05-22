Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  #counter
  resources :tictacs, only: [:index, :edit, :update] do
    collection do
      get :list
    end
  end
  
  #project
  resources :projects do
    resources :tasks, except: [:index] do
      member do
        patch :drag
        patch :toggle_status
      end
    end
  end

  resources :tasks, only: [] do
    collection do
      post :today_task
    end
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

  #charts
  resources :charts, only: [:index]
end
