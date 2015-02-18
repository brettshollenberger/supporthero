require 'rails_helper'

describe "Events API :" do
  before(:all) do
    Calendar.create_dates_in_year(2015)

    @other_user = FactoryGirl.create(:user, id: 2, first_name: "User 2", last_name: "Two")
    @third_user = FactoryGirl.create(:user, id: 3, first_name: "User 3", last_name: "Three")

    first_month     = CalendarDate.assignable.where(month: 1, year: 2015)
    first_five_days = first_month[0..4]
    next_five_days  = first_month[5..9]
    third_five_days = first_month[10..14]

    first_five_days.each do |day|
      FactoryGirl.create(:assignment, user: user, calendar_date: day)
    end

    next_five_days.each do |day|
      FactoryGirl.create(:assignment, user: @other_user, calendar_date: day)
    end

    third_five_days.each do |day|
      FactoryGirl.create(:assignment, user: @third_user, calendar_date: day)
    end

    @assignment = Assignment.first
    @other_users_assignment = Assignment.where(user: @other_user).first
    @third_users_assignment = Assignment.where(user: @third_user).first

    @request_to_switch_type = FactoryGirl.create(:event_type, :name => "request to switch")
    @request_to_switch = FactoryGirl.create(:event, event_type: @request_to_switch_type, 
                                                    creator: user, 
                                                    eventable: @assignment)
    FactoryGirl.create(:event_recipient, event: @request_to_switch, recipient: @other_user)

    @other_users_request_to_switch = FactoryGirl.create(:event, event_type: @request_to_switch_type, 
                                                    creator: @other_user, 
                                                    eventable: @assignment)
    FactoryGirl.create(:event_recipient, event: @other_users_request_to_switch, recipient: user)
  end

  describe "Index Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_events_path
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
          get api_v1_events_path
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with a list of all events" do
          expect(json.length).to eq(2)
          expect(json.first.creator.first_name).to eq(user.first_name)
          expect(json.first.eventable.id).to eq(@assignment.id)
          expect(json.first.eventable.type).to eq("Assignment")
          expect(json.first.eventable.user.id).to eq(user.id)
        end
      end

      describe "When no recipient_id is passed :" do
        before(:each) do
          get api_v1_events_path, {recipient_id: @other_user.id}
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It responds with only events for the provided user" do
          expect(json.length).to eq(1)
          expect(json.first.creator.first_name).to eq(user.first_name)
          expect(json.first.eventable.id).to eq(@assignment.id)
          expect(json.first.eventable.type).to eq("Assignment")
          expect(json.first.eventable.user.id).to eq(user.id)
        end
      end
    end
  end

  describe "Create Action :" do
    before(:each) do
      def valid_event_json
        { :format => :json, :creator_id => @third_user.id, :eventable_id => @third_users_assignment.id,
          :eventable_type => "Assignment", :event_type => "request to switch", 
          :recipient_ids => [user.id, @other_user.id] }
      end
    end

    describe "When logged in :" do
      before(:each) do
        login(@third_user)
      end

      describe "If I create a valid event :" do
        before(:each) do
          post api_v1_events_path(valid_event_json)

          @created_event = Event.find(json.id)
        end

        it "It is a successful request" do
          expect(response).to be_success
        end

        it "It renders the recently created event" do
          expect(json.creator.first_name).to eql(@third_user.first_name)
          expect(json.eventable.id).to eql(@third_users_assignment.id)
        end

        it "It makes all assigned users recipients" do
          expect(user.received_events).to include @created_event
          expect(@other_user.received_events).to include @created_event
        end
      end
    end
  end

  describe "Delete Action :" do
    describe "When not logged in :" do
      before(:each) do
        delete api_v1_event_path(@request_to_switch)
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

      describe "When the user may delete the event :" do
        before(:each) do
          delete api_v1_event_path(@request_to_switch)
        end

        it "is a successful request" do
          expect(response).to be_success
        end

        it "returns a message stating that the event was deleted successfully" do
          expect(json.message).to eql("Resource successfully deleted.")
        end
      end

      describe "When the user may not delete the availablity :" do
        before(:each) do
          delete api_v1_event_path(@other_users_request_to_switch)
        end

        it "is not a successful request" do
          expect(response).to_not be_success
        end

        it "returns a message stating the event is not found" do
          expect(json.error).to eql("Resource not found")
        end
      end
    end
  end
end
