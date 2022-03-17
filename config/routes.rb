Rails.application.routes.draw do
  resources :posts

  resources :channels
  resources :users

  delete '/remove_member/:id', to: 'channels#remove_member'
  get '/fetch_members/:id', to: 'channels#fetch_members'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  post 'auth/login', to: 'authentication#authenticate'
  mount ActionCable.server => '/cable'
end
