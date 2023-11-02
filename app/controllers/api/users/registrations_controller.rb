# frozen_string_literal: true
module Api
  module Users
    class RegistrationsController < Devise::RegistrationsController
      before_action :configure_sign_up_params, only: [:create]
      respond_to :json
      private

      def respond_with(resource, _opts = {})
        if request.method == "POST" && resource.persisted?
          render json: {
            status: {code: 200, message: "Signed up sucessfully."},
            data: UserSerializer.new(resource).serializable_hash[:data][:attributes]
          }, status: :ok
        elsif request.method == "DELETE"
          render json: {
            status: { code: 200, message: "Account deleted successfully."}
          }, status: :ok
        else
          render json: {
            status: {code: 422, message: "User couldn't be created successfully. #{resource.errors.full_messages.to_sentence}"}
          }, status: :unprocessable_entity
        end
      end

      def configure_sign_up_params
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number])
      end
    end

  end

end


