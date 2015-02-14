require 'rails_helper'

describe "Availabilities API :" do
  before(:all) do
    Calendar.create_dates_in_year(2015)

    @other_user = FactoryGirl.create(:user, id: 2, first_name: "User 2", last_name: "Two")

    first_month = CalendarDate.where(month: 1, year: 2015)
    first_five_days = first_month[0..4]
    next_five_days = first_month[5..9]

    first_five_days.each do |day|
      FactoryGirl.create(:availability, user: user, calendar_date: day)
    end

    next_five_days.each do |day|
      FactoryGirl.create(:availability, user: @other_user, calendar_date: day)
    end

    @availability = Availability.first
    @other_users_availability = Availability.last
  end

  describe "Index Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_availabilities_path
      end

      it "It is not a successful request" do
        expect(response).to_not be_success
      end

      it "It responds with an error message" do
        expect(json.error).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)

      end

      describe "When no query params are passed :" do
        before(:each) do
          get api_v1_availabilities_path
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with a list of all availabilities" do
          expect(json.length).to eq(10)
          expect(json.first.user.first_name).to eq(user.first_name)
          expect(json.first.calendar_date.month).to eq(1)
        end
      end

      describe "Filtering by user :" do
        before(:each) do
          get api_v1_availabilities_path, {user_id: user.id}
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "filters out the given users' availabilities" do
          expect(json.length).to eq(5)

          json.each do |availability|
            expect(availability.user.first_name).to eq(user.first_name)
          end
        end
      end

      describe "Filtering by calendar_date :" do
        before(:each) do
          @first_date = CalendarDate.first
          get api_v1_availabilities_path, {calendar_date_id: @first_date.id}
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "filters out the availabilities for the given calendar_date" do
          expect(json.length).to eq(1)

          expect(json.first.user.first_name).to eq(user.first_name)
        end
      end
    end
  end

  describe "Show Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_availability_path(@availability)
      end

      it "It is not a successful request" do
        expect(response).to_not be_success
      end

      it "It responds with an error message" do
        expect(json.error).to eq("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)
        get api_v1_availability_path(@availability)
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with the user's workspace, provided they are a collaborator" do
        expect(json.calendar_date.month).to eql(@availability.calendar_date.month)
      end
    end
  end

  describe "Create Action :" do
    before(:each) do
      def valid_availability_json
        { :format => :json, :user_id => user.id, :calendar_date_id => CalendarDate.last.id }
      end
    end

    describe "When not logged in :" do
      before(:each) do
        post api_v1_availabilities_path(valid_availability_json)
      end

      it "is not a successful request" do
        expect(response).to_not be_success
      end

      it "renders the login message" do
        expect(json.error).to eql("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)
      end

      describe "If I create a valid availability :" do
        before(:each) do
          post api_v1_availabilities_path(valid_availability_json)
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It renders the recently created workspace" do
          expect(json.user.first_name).to eql(user.first_name)
        end
      end
    end
  end

  describe "Delete Action :" do
    describe "When not logged in :" do
      before(:each) do
        delete api_v1_availability_path(@availability)
      end

      it "It is not successful" do
        expect(response).to_not be_success
      end

      it "It renders the login message" do
        expect(json.error).to eql("You need to sign in or sign up before continuing.")
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(user)
      end

      describe "When the user may delete the availability :" do
        before(:each) do
          delete api_v1_availability_path(@availability)
        end

        it "is a successful request" do
          expect(response).to be_success
        end

        it "returns a message stating that the workspace has been removed" do
          expect(json.message).to eql("Resource successfully deleted.")
        end
      end

      describe "When the user may not delete the availablity :" do
        before(:each) do
          delete api_v1_availability_path(@other_users_availability)
        end

        it "is not a successful request" do
          expect(response).to_not be_success
        end

        it "returns a message stating the not permitted error" do
          expect(json.error).to eql("You don't have permission to view or modify that resource")
        end
      end
    end
  end
end
