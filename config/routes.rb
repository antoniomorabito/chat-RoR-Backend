Rails.application.routes.draw do
  # Health check route
  get "up" => "rails/health#show", as: :rails_health_check

  # Chatrooms API
  resources :chatrooms, only: [:index, :create, :show] do
    resources :messages, only: [:index, :create]
  end

  # WebSockets for real-time chat
  mount ActionCable.server => "/cable"

  # Root path (default page)
  root "chatrooms#index"
end
