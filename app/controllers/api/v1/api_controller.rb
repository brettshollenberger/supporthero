module Api
  module V1
    class APIController < ApplicationController

    private
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
