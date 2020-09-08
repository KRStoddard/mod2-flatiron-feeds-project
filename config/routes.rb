Rails.application.routes.draw do
  resources :group_members
  resources :comments
  resources :posts
  resources :groups
  get '/groups/:id/members', to: 'groups#view_members', as: 'view_members'
  resources :users, except: [:index]
  get '/homepage', to: 'users#home', as: 'users_home'
  #get '/users/:id', to: 'users#show', as: 'user'
  post '/login', to: 'sessions#login', as: 'login'
  get '/sessions/new', to: 'sessions#new', as: 'new_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
