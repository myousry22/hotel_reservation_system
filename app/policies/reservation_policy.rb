class ReservationPolicy < ApplicationPolicy
  
    def cancel?
      user.guest?
    end
    
  end
  