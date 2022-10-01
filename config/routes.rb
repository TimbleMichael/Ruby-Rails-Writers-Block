Rails.application.routes.draw do
  resources :questions do
    resources :comments
  end

  root to: 'welcome#home'

  resources :users, except: [:new]

  get 'questions', to: 'questions#index'

  get '/auth/github/callback' => 'sessions#create'

  get 'signup', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: "sessions#destroy"

end
