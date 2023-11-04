
module Api
    module Rooms
        class RoomTypesController < ApiController
            def index
                @room_types = RoomType.all
                authorize @room_types
                render json: RoomTypeSerializer.new(@room_types).serializable_hash.to_json
            end
          
            def create
                @room_type = RoomType.new(room_type_params)
                authorize @room_type
                if @room_type.save
                  render json: serialize_room_type, status: :created
                else
                  render json: { errors: @room_type.errors }, status: :unprocessable_entity
                end
              end
          
              def update
                @room_type = RoomType.find(params[:id])
                authorize @room_type
                if @room_type.update(room_type_params)
                  render json: serialize_room_type, status: :ok
                else
                  render json: { errors: @room_type.errors }, status: :unprocessable_entity
                end
              end
          
            private
          
            def room_type_params
                params.require(:data)
                .require(:attributes)
                .permit(:description, :capacity, :price_per_night)
            end

            def serialize_room_type
              RoomTypeSerializer.new(@room_type).serializable_hash.to_json
            end

          end
    end
end