# USER MODEL
class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  JWT_ALGO = 'HS256'.freeze

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable,
         jwt_revocation_strategy: self

  # relations
  has_and_belongs_to_many :roles
  has_many :reservations

  # callbacks
  after_commit :assign_role, on: :create

  
  def generate_jwt_token
    exp = token_expired? ? 30.days.from_now : token_expires_at

    payload = {
      user_id: id,
      exp: exp.to_i
    }
    begin
        token = JWT.encode(payload, Rails.application.secrets.secret_key_base, JWT_ALGO)
        update(token_expires_at: exp)
        token 
    rescue JWT::EncodeError => e
        Rails.logger.error("JWT Encode Error: #{e.message}")
        nil
    end
  end

  def token_expired?
   return true unless token_expires_at.present?

   Time.now >= token_expires_at
  end 

  def admin?
    roles.find_by(name: 'admin')
  end

  def owner?
    roles.find_by(name: 'owner')
  end

  def operator?
    roles.find_by(name: 'operator')
  end

  def guest?
    roles.find_by(name: 'guest')
  end


  private

  def assign_role
    roles << guest_user
  end

  def guest_user
    Role.find_by(name: 'guest')
  end

end
