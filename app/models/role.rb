class Role < ApplicationRecord

    # validations 
    validates :name, presence: true, uniqueness: true
    
    # relations
    has_and_belongs_to_many :users
end
