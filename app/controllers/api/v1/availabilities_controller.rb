module Api
  module V1
    class AvailabilitiesController < ApplicationController
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

      def rescue_401_or_404(&block)
        begin
          block.call
        rescue ActiveRecord::RecordNotFound
          render not_found and return unless not_permitted?
          rescue_401_or_404 { raise NotPermitted }
        rescue NotPermitted
          render not_permitted and return
        end
      end

      def not_permitted?
        !!(Availability.where(id: params[:id]).first)
      end
      

      def unprocessable_entity
        { :json => @availability.errors, status: :unprocessable_entity }
      end

      def deleted
        { :json => {success: true, message: "Resource successfully deleted.", status: "204"} }
      end

      def not_found
        { :json => {success: false,
                    error: "Resource not found",
                    status: "404"}, status: :not_found }
      end

      def not_permitted
        { :json => {success: false, 
                    error: "You don't have permission to view or modify that resource",
                    status:  "401"}, 
                    :status => "401" }
      end
    end
  end
end
