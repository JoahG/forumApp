ForumApp::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "ranks" => "users#rank", :as => "ranks"
  root :to => "posts#index"
  resources :users
  resources :sessions
  resources :posts
  resources :comments
  resources :ncomments
  resources :notifications
  resources :plusones
end
