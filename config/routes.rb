Rails.application.routes.draw do
  resources :offers, only: :index
end
