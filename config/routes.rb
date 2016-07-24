Rails.application.routes.draw do
  resources :posts
  resources :users

  post "/signup" => "users#create"
  post "/login" => "users#login"
  get "/timeline" => "users#timeline"
  post "/follow" => "users#follow"
  post "/unfollow" => "users#unfollow"
  get "/following" => "users#following"
  post "/post" => "posts#create"
  get "/personal" => "users#personal"
  get "/search" => "posts#search"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
