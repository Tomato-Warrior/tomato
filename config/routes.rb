Rails.application.routes.draw do
  root "tasks#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }
  
  #counter
  resources :tictacs, only: [:index, :show]
  
  #task
  resources :tasks do
    member do
      patch :drag
    end
  end

  #project
  resources :projects


  #======確定路徑是否要這樣？

  resources :projects do 
    resources :tasks, only: [:new, :create, :index] do 
      member do
        patch :drag
      end
    end
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
  
end
