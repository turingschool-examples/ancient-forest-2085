Rails.application.routes.draw do
  resources :flights, only: :index do
    resources :passengers, only: :destroy, controller: "flights/passengers"
  end

  resources :airlines, only: :show
end
