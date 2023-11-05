class RoomType < ApplicationRecord
    validates :description, presence: true
    validates :capacity, presence: true, numericality: { only_integer: true }
    validates :price_per_night, presence: true, numericality: { greater_than_or_equal_to: 0 }

    has_many :reservations
end