Rails.application.routes.draw do
  root 'static_pages#welcome'

  resources :games, except: [:destroy]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
