Rails.application.routes.draw do
  # Index page
  root 'home#index'

  # User session
  resource :user_session, only: [:new, :create, :destroy]

  # Resources
  resources :courses
  resources :users
  resources :enrollments
end
