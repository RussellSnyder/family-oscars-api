Rails.application.routes.draw do
  resources :categories do
    resources :nominations do
      resources :votes
    end
  end
  post 'auth/login', to: 'authentication#authenticate'
  # post 'signup', to: 'users#create'
end
