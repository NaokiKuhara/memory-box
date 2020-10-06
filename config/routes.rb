Rails.application.routes.draw do
  devise_for :users
  get '/' => "home#top"
  get 'about' => "home#about"
  root 'pages#index'
  resources :users
  resources :posts
  post "posts/:id/update" => "posts#update"

end
