module Api
  module V1
    class CalendarDatesController < APIController
      before_filter :standardize_month, only: [:index]

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
        params.permit(:year, :month => [])
      end

      # Allow comma-separated list of months (?month=1,2,3)
      def standardize_month
        unless params["month"].nil?
          params["month"] = params["month"].split(",").map(&:to_i)
        end
      end
    end
  end
end
