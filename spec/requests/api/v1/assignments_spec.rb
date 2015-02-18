require 'rails_helper'

describe "Assignments API :" do
  before(:all) do
    Calendar.create_dates_in_year(2015)

    @other_user = FactoryGirl.create(:user, id: 2, first_name: "User 2", last_name: "Two")

    first_month = CalendarDate.assignable.where(month: 1, year: 2015)
    first_five_days = first_month[0..4]
    next_five_days = first_month[5..9]

    first_five_days.each do |day|
      FactoryGirl.create(:assignment, user: user, calendar_date: day)
    end

    next_five_days.each do |day|
      FactoryGirl.create(:assignment, user: @other_user, calendar_date: day)
    end

    @assignment = Assignment.first
    @other_users_assignment = Assignment.last
  end

  describe "Index Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_assignments_path
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
          get api_v1_assignments_path
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with a list of all assignments" do
          expect(json.length).to eq(10)
          expect(json.first.user.first_name).to eq(user.first_name)
          expect(json.first.calendar_date.month).to eq(1)
          expect(json.first.calendar_date.day_of_week).to eq("Friday")
        end
      end

      describe "Filtering by user :" do
        before(:each) do
          get api_v1_assignments_path, {user_id: user.id}
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "filters out the given users' assignments" do
          expect(json.length).to eq(5)

          json.each do |assignment|
            expect(assignment.user.first_name).to eq(user.first_name)
          end
        end
      end

      describe "Filtering by calendar_date :" do
        before(:each) do
          @first_date = CalendarDate.assignable.limit(1).first
          get api_v1_assignments_path, {calendar_date_id: @first_date.id}
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "filters out the assignments for the given calendar_date" do
          expect(json.length).to eq(1)

          expect(json.first.user.first_name).to eq(user.first_name)
        end
      end
    end
  end

  describe "Show Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_assignment_path(@assignment)
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
        get api_v1_assignment_path(@assignment)
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with the user's assignment" do
        expect(json.calendar_date.month).to eql(@assignment.calendar_date.month)
      end
    end
  end

  describe "Create Action :" do
    before(:each) do
      def valid_assignment_json
        { :format => :json, :user_id => user.id, :calendar_date_id => CalendarDate.last.id }
      end
    end

    describe "When not logged in :" do
      before(:each) do
        post api_v1_assignments_path(valid_assignment_json)
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

      describe "If I create a valid assignment :" do
        before(:each) do
          post api_v1_assignments_path(valid_assignment_json)
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It renders the recently created assignment" do
          expect(json.user.first_name).to eql(user.first_name)
        end
      end
    end
  end

  describe "Delete Action :" do
    describe "When not logged in :" do
      before(:each) do
        delete api_v1_assignment_path(@assignment)
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

      describe "When the user may delete the assignment :" do
        before(:each) do
          delete api_v1_assignment_path(@assignment)
        end

        it "is a successful request" do
          expect(response).to be_success
        end

        it "returns a message stating that the assignment has been removed" do
          expect(json.message).to eql("Resource successfully deleted.")
        end
      end

      describe "When the user may not delete the assignment :" do
        before(:each) do
          delete api_v1_assignment_path(@other_users_assignment)
        end

        it "is not a successful request" do
          expect(response).to_not be_success
        end

        it "does not display resource to the user" do
          expect(json.error).to eql("Resource not found")
        end
      end
    end
  end
end
