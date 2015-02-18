module Api
  module V1
    class AssignmentsController < APIController
      def index
        rescue_401_or_404 do
          @assignments = Assignment.where(queryable_params).includes(:user, :calendar_date)
        end
      end

      def show
        rescue_401_or_404 do
          @assignment = Assignment.find(params[:id])
        end
      end

      def create
        @assignment = Assignment.new(assignment_params)

        render :show and return if @assignment.save
          
        render unprocessable_entity
      end

      def update
        @assignment = Assignment.find(params[:id])

        if @assignment.update(assignment_params)
          render :show and return
        else
          render unprocessable_entity
        end
      end

      def destroy
        rescue_401_or_404 do
          @assignment = current_user.assignments.find(params[:id])

          render deleted and return if !@assignment.nil? && @assignment.destroy
          render not_permitted
        end
      end

    private
      def queryable_params
        params.permit(:user_id, :calendar_date_id)
      end

      def assignment_params
        params.permit(:user_id, :calendar_date_id)
      end
    end
  end
end
