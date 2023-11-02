class ApplicationController < ActionController::API
    # before_action :authenticate_user

    def authenticate_user
      token = request.headers['Authorization']&.split(' ')&.last
      return render_unauthorized unless token
  
      begin
        decoded_token = JWT.decode(token, Rails.application.secrets.secret_key_base, true, algorithm: USER::JWT_ALGO)
        payload = decoded_token.first
        @current_user = User.find(payload['user_id'])
      rescue JWT::DecodeError
        render_unauthorized
      end
    end


  private

  def render_unauthorized
    render json: { error: 'Unauthorized' }, status: :unauthorized
  end

end
