class Reservation < ApplicationRecord
    belongs_to :user
    belongs_to :room_type
  
    validates :start_date, :end_date, :user_id, :room_type_id, presence: true
    validate :no_overlapping_reservations
    # validate :valid_date_format, on: :create

    # scopes 
    scope :overlapping_reservations, lambda { |start_date, end_date, room_type_id|
                 where(room_type_id: room_type_id)
                 .where('start_date < ? AND end_date > ?', end_date, start_date)
      }

    

    private

    def no_overlapping_reservations
      if self.class.overlapping_reservations(start_date, end_date, room_type_id).exists?
        errors.add(:base, 'Reservation conflicts with existing reservations, this room already reserved in this period')
      end
    end

    def valid_date_format
        date_format = /\A\d{4}-\d{2}-\d{2}\z/
        
        if start_date.present? && start_date !~ date_format
          errors.add(:start_date, "must be in the format 'YYYY-MM-DD'")
        end
    
        if end_date.present? && end_date !~ date_format
          errors.add(:end_date, "must be in the format 'YYYY-MM-DD'")
        end
    end
  
    # def start_date 
        # date_formatter(start_date)
    # end

    # def end_date
        # date_formatter(end_date)
    # end

    def date_formatter(date)
        parsed_date = Date.parse(date)
        parsed_date.strftime('%Y-%m-%d')
    end
end