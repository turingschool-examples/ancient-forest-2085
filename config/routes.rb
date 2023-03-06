Rails.application.routes.draw do
  resources :flights, only: [:index] do
    resources :passenger_flights, only: [:destroy]
  end
  resources :airlines, only: [:show]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
