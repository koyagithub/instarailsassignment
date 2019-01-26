Rails.application.routes.draw do

  #Setting 
  get 'users/readme' => 'users#readme'
  get 'users/post' => 'users#post'
  
  #password edit
  get 'users/pass_edit' => 'users#pass_edit'
  patch 'users/pass_edit' => 'users#pass_update'
  
  #Root and resources for users & user_sessions
  root :to => 'users#index'
  resources :user_sessions
  resources :users do 
    member do
      get :activate
    end
  end

  #Login and logout
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  #password reset 
  resources :password_resets
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  
  #External
  get 'oauths/oauth'
  get 'oauths/callback'
  
  #microposts 
  resources :microposts,          only: [:create, :destroy]

  #Facebook authentication
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
