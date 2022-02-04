Rails.application.routes.draw do
  root 'welcome#index'
  get '/welcome/index', to: 'welcome#index'

  get '/register', to: 'users#new'

  post '/users', to: 'users#create'
  get '/users/:id', to: 'users#show'
  get '/users/:id/discover', to: 'users#discover'
  get '/users/:user_id/movies/:movie_id', to: 'movies#show'
  get '/users/:user_id/movies/:movie_id/viewing-party/new', to: 'user_party#new'
  get '/users/:user_id/movies', to: 'movies#results'
  # resource :users, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
