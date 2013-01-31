ForumApp::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "stats" => "users#rank", :as => "stats"
  root :to => "posts#index"

  post "comments/:id" => "comments#update"

  resources :users do 
    member do
      get 'make_admin'
      get 'make_not_admin'
      get 'make_mod'
      get 'make_not_mod'
      get 'dismiss_all_notifications'
      get 'refresh'
    end
  end
  
  resources :sessions
  resources :posts
  resources :comments
  resources :ncomments
  resources :notifications
  resources :plusones
  resources :forums
end
