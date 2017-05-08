Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    resources :geolocations, only: :show, constraints: { id: /[0-9.]+/ }


  end
end
