Rails.application.routes.draw do
  devise_for :users, :controllers => { :omniauth_callbacks => "callbacks" }
  #counter
  resources :counters
  #task
  resources :tasks
  #project
  resources :projects

  
  root "tasks#index"
end
