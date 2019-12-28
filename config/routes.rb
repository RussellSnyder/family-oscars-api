Rails.application.routes.draw do
  resources :categories do
    resources :nominations do
      resources :votes
    end
  end
end
