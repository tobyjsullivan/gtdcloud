require 'spec_helper'

describe Api::V1::AccountsController do
  describe "GET #show" do
    before(:each) do
      @account = FactoryGirl.create :account
      get :show, id: @account.id
    end

    it "returns the information about a reporter on a hash" do
      account_response = json_response
      expect(account_response[:email]).to eql @account.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @account_attributes = FactoryGirl.attributes_for :account
        post :create, { account: @account_attributes }
      end

      it "renders the json representation for the account record just created" do
        account_response = json_response
        expect(account_response[:email]).to eql @account_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_account_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { account: @invalid_account_attributes }
      end

      it "renders an errors json" do
        account_response = json_response
        expect(account_response).to have_key(:errors)
      end

      it "renders the json errors on why the account could not be created" do
        account_response = json_response
        expect(account_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end

  describe "PUT/PATCH #update" do

    context "when is successfully updated" do
      before(:each) do
        @account = FactoryGirl.create :account
        patch :update, { id: @account.id,
                         account: { email: "newmail@example.com" } }
      end

      it "renders the json representation for the updated account" do
        account_response = json_response
        expect(account_response[:email]).to eql "newmail@example.com"
      end

      it { should respond_with 200 }
    end

    context "when is not created" do
      before(:each) do
        @account = FactoryGirl.create :account
        patch :update, { id: @account.id,
                         account: { email: "bademail.com" } }
      end

      it "renders an errors json" do
        account_response = json_response
        expect(account_response).to have_key(:errors)
      end

      it "renders the json errors on whye the account could not be created" do
        account_response = json_response
        expect(account_response[:errors][:email]).to include "is invalid"
      end

      it { should respond_with 422 }
    end
  end
end
