Rails.application.routes.draw do
  root "tasks#index"
  devise_for :users
  #counter
  resources :tictacs do
    member do
      patch :cancel
      patch :finish
    end
  end
  
  #task
  resources :tasks
  #project
  resources :projects

  #Api
  namespace :api do
    resources :tictacs, only: [] do
      member do
        post :start
        post :cancel
        post :finish
      end
    end
  end

end
