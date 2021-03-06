require 'rails_helper'

describe "Users API :" do
  describe "Index Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_users_path
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
        get api_v1_users_path
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with all users" do
        expect(json.first.email).to eql(user.email)
      end
    end
  end

  describe "Show Action :" do
    describe "When not logged in :" do
      before(:each) do
        get api_v1_user_path(user)
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
        get api_v1_user_path(user)
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with the user" do
        expect(json.email).to eql(user.email)
        expect(json.first_name).to eql(user.first_name)
        expect(json.last_name).to eql(user.last_name)
        expect(json.admin).to eql(user.admin)
      end
    end

    describe "Using 'me' parameter" do
      before(:each) do
        login(user)
        get api_v1_user_path({ id: "me" })
      end

      it "It is a successful request" do
        expect(response).to be_success
      end

      it "It responds with the user" do
        expect(json.email).to eql(user.email)
        expect(json.first_name).to eql(user.first_name)
        expect(json.last_name).to eql(user.last_name)
        expect(json.admin).to eql(user.admin)
      end
    end
  end
end
