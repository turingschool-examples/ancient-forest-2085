Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/airlines/:id', to: 'airlines#show'
  get '/flights', to: 'flights#index'
  delete "/passenger_flights/:id", to: "passenger_flights#destroy"
end
