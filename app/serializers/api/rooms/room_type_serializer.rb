
module Api
  module Rooms
    class RoomTypeSerializer
      include JSONAPI::Serializer
      attributes :id, :description, :capacity


      attribute :price_per_night do |object|
        object.price_per_night.to_f
      end
    end  
  end
  
end








