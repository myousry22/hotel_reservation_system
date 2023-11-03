# USER MODEL
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  JWT_ALGO = 'HS256'.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  def generate_jwt_token
    exp = token_expired? ? 1.minutes.from_now : token_expires_at

    payload = {
      user_id: id,
      exp: exp.to_i
    }
    token = JWT.encode(payload, Rails.application.secrets.secret_key_base, JWT_ALGO)
    update(token_expires_at: exp)
    token 
  end

  def token_expired?
   return true unless token_expires_at.present?

   Time.now >= token_expires_at
  end
 
end
