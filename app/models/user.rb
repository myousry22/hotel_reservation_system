# USER MODEL
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  JWT_ALGO = 'HS256'.freeze
  JWT_EXP = 30.days.from_now.to_i

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self


  def generate_jwt_token
    payload = {
      user_id: id,
      exp: JWT_EXP
    }
    JWT.encode(payload, Rails.application.secrets.secret_key_base, JWT_ALGO)
  end
 
end
