Rails.application.routes.draw do
  resources :flights, only: [:index]
  resources :passenger_flights, only: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
