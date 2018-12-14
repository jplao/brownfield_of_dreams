Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :tutorials, only:[:show, :index]
      resources :videos, only:[:show]
    end
  end

  root 'welcome#index'
  get '/auth/github/callback', to: 'github/sessions#create'
  get 'tags/:tag',             to: 'welcome#index', as: :tag
  get '/register',             to: 'users#new'
  get '/friendship',           to: 'friendships#create'
  post '/friendship',          to: 'friendships#create'

  namespace :admin do
    get "/dashboard", to: "dashboard#show"
    resources :tutorials, only: [:create, :edit, :update, :destroy, :new] do
      resources :videos, only: [:create]
    end
    resources :videos, only: [:edit, :update, :destroy]

    namespace :api do
      namespace :v1 do
        put "tutorial_sequencer/:tutorial_id", to: "tutorial_sequencer#update"
      end
    end
  end

  get '/login',         to: "sessions#new"
  post '/login',        to: "sessions#create"
  delete '/logout',     to: "sessions#destroy"
  resources :account_activations, only: [:edit]

  get '/dashboard',     to: 'dashboard#show'
  get '/invite',        to: 'invite#show'
  get '/create_invite', to: 'invite#create', as: 'create_invite'
  get '/about',         to: 'about#show'
  get '/get_started',   to: 'get_started#show'

  resources :users, only: [:new, :create, :update, :edit]

  resources :tutorials, only: [:show, :index] do
    resources :videos,  only: [:show, :index]
  end

  resources :user_videos, only:[:create, :destroy]
end
