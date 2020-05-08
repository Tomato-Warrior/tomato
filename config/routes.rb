Rails.application.routes.draw do
  devise_for :users
  #counter
  resources :tictacs
  #task
  resources :tasks
  #project
  resources :projects

  root "tasks#index"

end
