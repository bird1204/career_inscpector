Rails.application.routes.draw do
  devise_for :users
  # Root
  root 'landing_pages#index'

  resources :jobs do
    member do
      put "like", to: "jobs#upvote"
      put "dislike", to: "jobs#downvote"
    end
    collection do
      get 'search'
    end
  end

end
