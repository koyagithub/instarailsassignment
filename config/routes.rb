Rails.application.routes.draw do
  get 'oauths/oauth'

  get 'oauths/callback'

  root :to => 'users#index'
  resources :user_sessions
  resources :users
  
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout

  #facebook authentication
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
