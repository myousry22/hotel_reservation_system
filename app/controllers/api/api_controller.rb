class Api::ApiController < ApplicationController
    before_action :authenticate_user
  
    def authenticate_user
      token = request.headers['Authorization']&.sub('Bearer ', '')
      return render_unauthorized unless token

      decoded_token = decode_token(token)
      return render_token_expired unless decoded_token

      @current_user = find_user(decoded_token[0]['user_id'])

      return render_unauthorized unless @current_user
    end
  
    private
  
    def decode_token(token)
      begin
        JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: User::JWT_ALGO)
      rescue JWT::DecodeError
        nil
      end
    end
  
    def find_user(user_id)
      User.find(user_id)
    end
  
    def render_unauthorized
      render json: { error: 'You are not authorized to access this resource' }, status: :unauthorized
    end

    def render_token_expired
        render json: { error: 'Your session has expired, you must login again' }, status: :unauthorized
    end
  end