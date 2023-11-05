Rails.application.routes.draw do
  
  namespace :api, path: '/api' do 
    get '/current_user', to: 'current_user#index'
    namespace :rooms, path: '/rooms' do 
      resources :room_types, only: [:create, :update, :index]
      resources :reservations, only: [:create, :index] do 
        collection do 
          delete '/:id/cancel', to: 'reservations#cancel'
        end
      end
    end
  end
  
    devise_for :users, path: '', path_names: {
      sign_in: 'api/login',
      sign_out: 'logout',
      registration: 'api/register'
    },
    controllers: {
      sessions: 'api/users/sessions',
      registrations: 'api/users/registrations'
    }

end
