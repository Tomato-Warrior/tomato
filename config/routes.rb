Rails.application.routes.draw do
  devise_for :users
  # Project
  resources :projects
end
