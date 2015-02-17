module Api
  module V1
    class CalendarDatesController < APIController
      def index
        rescue_401_or_404 do
          @calendar_dates = CalendarDate.where(queryable_params)
                                        .includes(assignment: [:user], 
                                                  availabilities: [:user],
                                                  holiday: [])
        end
      end

      def show
        rescue_401_or_404 do
          @calendar_date = CalendarDate.find(params[:id])
        end
      end

    private
      def queryable_params
        params.permit(:month, :year)
      end
    end
  end
end
