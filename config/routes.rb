Rails.application.routes.draw do
  # Root
  root 'landing_pages#index'

  resources :jobs do
    member do
      get 'analytics'
    end

    collection do
      get 'search'
    end
  end

end
