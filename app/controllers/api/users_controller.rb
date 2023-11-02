# app/controllers/api/v1/users_controller.rb
class Api::UsersController < ApplicationController
  def register
    # Parse and validate user parameters (e.g., email, password)
    user = User.new(email: user_params[:email], password: user_params[:password],
       phone_number: user_params[:phone_number], username: user_params[:username])

    
    if user.save
      render json: { message: 'Registration successful' }, status: :created
    else
      render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def login
    user = User.find_by(email: params[:email])

    if user && user.valid_password?(params[:password])
      # Generate and return a token (JWT or other) for authentication
      render json: { token: user.generate_token, user_id: user.id }
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :username, :phone_number)
  end
end
