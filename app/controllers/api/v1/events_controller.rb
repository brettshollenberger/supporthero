module Api
  module V1
    class EventsController < APIController
      before_filter :standardize_params, :only => [:create]

      def index
        rescue_401_or_404 do
          if params.include?("recipient_id")
            @recipient = User.find(params["recipient_id"])
            @events    = @recipient.received_events
          else
            @events = Event.where(queryable_params)
          end
        end
      end

      def create
        @event = Event.new(event_params)

        if @event.save
          add_recipients

          render :show and return
        end

        render unprocessable_entity
      end

      def destroy
        rescue_401_or_404 do
          @event = current_user.created_events.find(params[:id])

          render deleted and return if !@event.nil? && @event.destroy
          render not_permitted
        end
      end

    private
      def queryable_params
        params.permit()
      end

      def standardize_params
        find_event_type
        add_recipient_ids
      end

      def find_event_type
        if params["event_type"]
          params["event_type_id"] = EventType.where(name: params["event_type"]).first.id
        end
      end

      def add_recipients
        params["recipient_ids"].each do |recipient_id|
          EventRecipient.create(event: @event, recipient_id: recipient_id)
        end
      end

      def add_recipient_ids
        if params["recipient_ids"].nil?
          params["recipient_ids"] = []
        end
      end

      def event_params
        params.permit(:creator_id, :eventable_id, :eventable_type, :event_type_id)
      end
    end
  end
end
