Rails.application.routes.draw do
  # namespace :api, path: '' do 
  
    devise_for :users, path: '', path_names: {
      sign_in: 'api/login',
      sign_out: 'logout',
      registration: 'api/register'
    },
    controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }
  # end
  # post '/api/register', to: 'api/users#register'
  # post '/api/login', to: 'api/users#login'



end
