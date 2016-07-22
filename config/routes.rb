Rails.application.routes.draw do
  resources :posts
  resources :users

  post "/signup" => "users#create"
  post "/login" => "users#login"
  get "/timeline" => "users#show"
  # post "/follow" => ""
  # post "/unfollow" => ""
  # post "/user_list" => ""
  post "/post_tweet" => "post#create"


  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
