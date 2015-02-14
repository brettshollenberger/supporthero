include Warden::Test::Helpers

module Requests
  module JsonHelpers
    def user
      @user ||= FactoryGirl.create(:user, id: 1)
    end

    def login(user)
      login_as user, scope: :user
    end

    def json
      if @json.nil?
        json = JSON.parse(response.body)

        if json.is_a?(Array)
          @json = json.map { |item| RecursiveOpenStruct.new(item) }
        else
          @json = RecursiveOpenStruct.new(JSON.parse(response.body))
        end
      else
        @json
      end
    end
  end
end
