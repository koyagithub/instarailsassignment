Rails.application.routes.draw do
  #Setting 
  get 'users/readme' => 'users#readme'
  get 'users/post' => 'users#post'
  get 'users/noti' => 'users#notification'
  
  #Password edit
  get 'users/pass_edit' => 'users#pass_edit'
  patch 'users/pass_edit' => 'users#pass_update'
  
  #Root and resources for users & user_sessions
  root :to => 'users#top'
  resources :user_sessions
  resources :users do 
    member do
      get :activate
    end
    member do
      get :following, :followers
    end    
  end

  #Login and logout
  get 'login' => 'user_sessions#new', :as => :login
  post 'logout' => 'user_sessions#destroy', :as => :logout
  
  #Password reset 
  resources :password_resets
  get 'password_resets/create'
  get 'password_resets/edit'
  get 'password_resets/update'
  
  #External
  get 'oauths/oauth'
  get 'oauths/callback'
  
  #Microposts 
  resources :microposts,          only: [:create, :destroy] do
  #Comments
    resources :comments, only: [:index, :create, :edit, :update, :destroy]
  end
  
  #Relationships
  resources :relationships,       only: [:create, :destroy]
  
  #Likes
  post   '/like/:micropost_id' => 'likes#like',   as: 'like'
  delete '/like/:micropost_id' => 'likes#unlike', as: 'unlike'

  #Facebook authentication
  post "oauth/callback" => "oauths#callback"
  get "oauth/callback" => "oauths#callback" # for use with Github, Facebook
  get "oauth/:provider" => "oauths#oauth", :as => :auth_at_provider
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
