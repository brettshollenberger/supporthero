module Api
  module V1
    class UsersController < APIController
      def show
        rescue_401_or_404 do
          @user = User.find(params[:id])
        end
      end
    end
  end
end
