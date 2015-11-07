Rails.application.routes.draw do
  # Index page
  root 'home#index'

  # User session
  resource :user_session, only: [:new, :create, :destroy]

  # Resources
  resources :courses do
    resources :feeds
  end

  resources :users
  resources :enrollments

  # APIs
  namespace :api, defaults: {format: :json} do
    resources :courses
  end

  # Activations
  get 'activate/:activation_code', to: 'activations#create', as: 'activate'
end
