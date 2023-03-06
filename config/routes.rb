Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :flights, only: :index do
  end

  resources :airlines, only: :show do
  end

  delete '/flights/:flight_id/passengers/:id', to: 'flight_passengers#destroy'
end
