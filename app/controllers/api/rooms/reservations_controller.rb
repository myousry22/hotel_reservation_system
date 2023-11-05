module Api
    module Rooms
        class ReservationsController < ApiController
            include ReservationHelper
            before_action :find_room, only: [:create, :update]
          
            def create
                permitted_params = reservation_params.merge(user_id: current_user.id)
                result = CreateReservationInteractor.call(reservation_params: permitted_params)

                if result.success?
                    render json: ReservationSerializer.new(result.reservation), status: :created
                else
                    render json: { errors: result.errors }, status: :unprocessable_entity
                end
            rescue Date::Error => e
                # Handle the custom error
                render json: { error: e.message }, status: :unprocessable_entity
            end
          
            def cancel
                @reservation = Reservation.find(params[:id])
                @reservation.destroy!
                render json: { message: 'The reservation canceled successfully' }, status: :ok
            rescue ActiveRecord::RecordNotDestroyed => e
                render json: { errors: e.record.errors.full_messages }, status: :unprocessable_entity
            rescue ActiveRecord::RecordNotFound => e
                render json: { error: { message: 'this reservation not found' } }, status: 404
              
            end
          
            def index
              if params[:start_date].present? && params[:end_date].present?
                # Fetch reservations for the specified date range
                @reservations = Reservation.where("start_date >= ? AND end_date <= ?", params[:start_date], params[:end_date])
              else
                # Fetch all reservations when date range parameters are null
                @reservations = Reservation.all
              end
          
              render json: ReservationSerializer.new(@reservations).serializable_hash.to_json, status: :ok
      
            end
          
            private
          
            def reservation_params
              params.require(:reservation).permit(:start_date, :end_date, :room_type_id)
            end

            def find_room
                @room = RoomType.find(reservation_params[:room_type_id]).id
                render json: { message: 'Room not found' }, status: 404 unless @room
            end
          end
    end
end






























