class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room_type
  
    validates :start_date, :end_date, :user_id, :room_type_id, presence: true
    validate :no_overlapping_reservations
    validate :valid_date_format, on: :create

    # scopes 
    scope :overlapping_reservations, lambda { |start_date, end_date, room_type_id|
                 where(room_type_id: room_type_id)
                 .where('start_date < ? AND end_date > ?', end_date, start_date)
      }

    scope :for_guest, ->(user) { where(user: user) }
    scope :for_admin, -> { all }
    scope :for_operator, -> { all }
    scope :for_owner, -> { all }

    

    private

    def no_overlapping_reservations
      if self.class.overlapping_reservations(start_date, end_date, room_type_id).exists?
        errors.add(:base, 'Reservation conflicts with existing reservations, this room already reserved in this period')
      end
    end

    def valid_date_format
    
        if start_date.present? && start_date < Date.today
          errors.add(:start_date, "can't be in the past")
        end

        if end_date.present? && end_date < Date.today
          errors.add(:end_date, "can't be in the past")
        end

    end
  
end