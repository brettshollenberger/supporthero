module Api
  module V1
    class UsersController < APIController
      def index
        rescue_401_or_404 do
          @users = User.all
        end
      end

      def show
        rescue_401_or_404 do
          @user = User.find(show_id)
        end
      end

    private
      def show_id
        params[:id] == "me" ? current_user.id : params[:id]
      end
    end
  end
end
