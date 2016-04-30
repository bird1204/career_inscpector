Rails.application.routes.draw do
  # Root
  root 'landing_pages#index'

  resources :jobs do
    collection do
      get 'search'
    end
  end
end
