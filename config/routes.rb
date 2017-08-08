Rails.application.routes.draw do
  root 'static_pages#welcome'

  resources :games, except: [:destroy, :edit]

  get '/load', to: 'games#load_game_from_session_id', as: 'load'

  get 'games/:id/evaluate', to: 'games#evaluate', as: 'evaluate'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
