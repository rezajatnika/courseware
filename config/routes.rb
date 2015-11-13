Rails.application.routes.draw do
  # Index page
  root 'home#index'

  # User session
  resource :user_session, only: [:new, :create, :destroy]

  # Resources
  resources :courses do
    resources :feeds, only: [:create, :destroy, :update]
  end

  resources :users, only: [:new, :create]
  resources :enrollments, only: [:create, :destroy]

  # APIs
  namespace :api do
    resources :courses, only: [:index, :show]
  end

  # Activations
  get 'activate/:activation_code', to: 'activations#create', as: 'activate'
end
