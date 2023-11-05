class CreateReservationInteractor
    include Interactor
  
    def call
      ActiveRecord::Base.transaction do
        reservation = Reservation.new(context.reservation_params)
  
        if reservation.save
          context.reservation = reservation
        else
          context.fail!(errors: reservation.errors.full_messages)
          raise ActiveRecord::Rollback
        end
      end
    end
end
  