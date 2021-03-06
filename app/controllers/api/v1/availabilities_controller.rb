module Api
  module V1
    class AvailabilitiesController < APIController
      def index
        rescue_401_or_404 do
          @availabilities = Availability.where(queryable_params).includes(:user, :calendar_date)
        end
      end

      def show
        rescue_401_or_404 do
          @availability = Availability.find(params[:id])
        end
      end

      def create
        @availability = Availability.new(availabilities_params)

        render :show and return if @availability.save
          
        render unprocessable_entity
      end

      def destroy
        rescue_401_or_404 do
          @availability = current_user.availabilities.find(params[:id])

          render deleted and return if !@availability.nil? && @availability.destroy
          render not_permitted
        end
      end

    private
      def queryable_params
        params.permit(:user_id, :calendar_date_id)
      end

      def availabilities_params
        params.permit(:user_id, :calendar_date_id)
      end
    end
  end
end
