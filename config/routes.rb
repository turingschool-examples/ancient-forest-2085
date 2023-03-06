Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  get '/flights', to: 'flight#index'

  delete "/passenger_flights/:passenger_id/:flight_id",  to: 'passenger_flights#destroy'

  get '/airlines/:id', to: 'airline#show'
end
