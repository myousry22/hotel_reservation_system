# frozen_string_literal: true
module Api
  module Users
    class SessionsController < Devise::SessionsController
      respond_to :json

      private
    
      def respond_with(resource, _opts = {})
        
          if resource.persisted?
            token = resource.generate_jwt_token
            render json: { token: token, 
                   data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
            }
          else
            render json: { error: 'Invalid email or password' }, status: :unauthorized
          end
      end
    end
  end
end
























