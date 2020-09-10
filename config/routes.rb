Rails.application.routes.draw do
  resources :messages
  resources :chatmembers
  resources :chats
  resources :replies
  resources :group_members, only: [:create, :destroy]
  resources :comments, except: [:index]
  resources :posts, except: [:index]
  resources :groups, except: [:edit, :update]
  get '/groups/:id/members', to: 'groups#view_members', as: 'view_members'
  resources :users, except: [:index, :udpate, :edit]
  get '/homepage', to: 'users#home', as: 'users_home'
  #get '/users/:id', to: 'users#show', as: 'user'
  post '/login', to: 'sessions#login', as: 'login'
  get '/sessions/new', to: 'sessions#new', as: 'new_login'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  delete '/sessions/delete', to: 'sessions#logout', as: 'logout'
  patch '/posts/:id/like', to: 'posts#like', as: 'like'
  patch '/comments/:id/like', to: 'comments#like', as: 'like_comment'
  patch '/replies/:id/like', to: 'replies#like', as: 'like_reply'

end
