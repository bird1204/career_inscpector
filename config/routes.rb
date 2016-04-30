Rails.application.routes.draw do
  # Root
  root 'jobs#index'

  resources :jobs do
    member do
      get 'analytics'
    end

    collection do
      get 'search'
    end
  end

end
