Rails.application.routes.draw do
  post '/api/register', to: 'api/users#register'
  post '/api/login', to: 'api/users#login'
  devise_for :users
  
  

end
