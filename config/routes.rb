Rails.application.routes.draw do
  # Root
  root 'jobs#index'

  resources :jobs do
    collection do
      get 'search'
    end
  end
end
