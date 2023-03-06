Rails.application.routes.draw do
  resources :flights, only: :index do
    resources :passenger_flights, only: :destroy
  end

  resources :airlines, only: :show
end
