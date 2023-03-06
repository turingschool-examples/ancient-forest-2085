Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

resources :flights, only: [:index] 

delete "/flights/:id/passengers", to: "flights#destroy"

get "/airlines/:id", to: "airlines#show"
end
