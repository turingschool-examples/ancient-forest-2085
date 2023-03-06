Rails.application.routes.draw do
  resources :flights, only: :index do
    resources :flight_passengers, only: :destroy, controller: "flights/flight_passengers"
  end
end
