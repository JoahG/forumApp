ForumApp::Application.routes.draw do
  get "log_in" => "sessions#new", :as => "log_in"
  get "log_out" => "sessions#destroy", :as => "log_out"
  get "sign_up" => "users#new", :as => "sign_up"
  get "comment" => "comments#new", :as => "comment"
  root :to => "posts#index"
  resources :users
  resources :sessions
  resources :posts
  resources :comments
end
