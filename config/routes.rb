Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'sessions#new'

  # oauth2 redirect_uri creates a session with the appropriate code
  get '/oauth2/callback', to: 'sessions#create'
  
  resources :sessions

end
