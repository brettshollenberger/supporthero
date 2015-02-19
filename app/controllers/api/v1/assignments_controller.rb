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

        render :show and return if persist_assignment
          
        render unprocessable_entity
      end

      def update
        @assignment = Assignment.find(params[:id])
        @assignment.assign_attributes(assignment_params)

        if persist_assignment
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

      def persist_assignment(&block)
        changed_user = @assignment.user_id_changed?

        valid = @assignment.save

        create_change_event if valid && changed_user

        valid
      end

      def create_change_event
        if @assignment.calendar_date.availabilities.map(&:user).include?(@assignment.user)
          event_type_name = "assigned shift"
        else
          event_type_name = "assigned unavailable shift"
        end

        event_type = EventType.where(name: event_type_name).first
        event      = Event.create(eventable: @assignment, creator: current_user, event_type: event_type)
        EventRecipient.create(event: event, recipient: @assignment.user)
      end
    end
  end
end
