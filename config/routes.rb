Rails.application.routes.draw do
  devise_for :users
  resources :counters
  
  #task
  resources :tasks
end
