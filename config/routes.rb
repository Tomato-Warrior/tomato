Rails.application.routes.draw do
  root "home#index"
  devise_for :users, controllers: { omniauth_callbacks: "users/omniauth_callbacks" }

  resources :tictacs, only: [:index, :update] do
    collection do
      get :list
    end
    # tictac list edit
    member do
      get :cancelled
      get :finished
    end
  end

  resources :projects do
    # project chart
    member do
      get :chart
    end
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
      post :cancelled_tictac
      post :finished_tictac
    end
    resource :tictac, only: [:show]
  end

  namespace :api do
    namespace :v1 do
      # google extension
      post 'login' => 'authentication#login'
      post 'logout' => 'authentication#logout'
      post 'gettasks' => 'tasks#gettasks'
      post 'startwork' => 'tasks#startwork'
      post 'finishwork' => 'tasks#finishwork'
      post 'cancelwork' => 'tasks#cancelwork'

      resources :projects, only: [] do
        resources :tasks, only: [:index, :create, :update]
      end
      resources :tasks, only: [:destroy] do 
        member do
          patch :toggle_status      
        end
      end

      resources :tictacs, only: [] do
        collection do
          post :start
          get :heatmap
        end
        member do
          post :cancel
          post :finish
        end
      end

      resources :user, only: [] do
        member do
          patch :time_setting
        end
      end
    end
  end

  # homepage
  resources :home, only: [:index] do
    collection do
      get :todo
    end
  end

  # charts
  resources :charts, only: [:index]

  # trello
  resources :trelloapi, only: [:index] do
    collection do
      post :get_token
      post :import_selected_list
      post :get_board
      post :import_assigned_cards
      post :change_list
      post :get_list_data
      get :select_assigned_cards_of_list
      get :select_board
      get :select_list_cards
    end
  end

  #webhook
  get "/webhooks/receive", to: "webhooks#complete"
  post "/webhooks/receive", to: "webhooks#receive"
end
