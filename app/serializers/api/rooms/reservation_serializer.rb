
module Api
    module Rooms
      class ReservationSerializer
        include JSONAPI::Serializer
        attributes :id, :start_date, :end_date
  
  
        attribute :user_email do |object|
          object.user.email
        end

        attribute :room do |object|
            object.room_type.description
          end
      end  
    end
    
end