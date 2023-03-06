Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  # get "/flights", to: "flights#index"
  
  # delete "flights/:flight_id/passengers/:id", to: "passengers#destroy"

  # get "/airlines/:id", to: "airlines#show"

  resources :flights, only: [:index] do
    resources :passengers, only: [:destroy]
   end
  
   resources :airlines, only: [:show]
end
