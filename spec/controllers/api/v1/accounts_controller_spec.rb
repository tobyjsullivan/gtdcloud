require 'spec_helper'

describe Api::V1::AccountsController do
  before(:each) { request.headers['Accept'] = "application/vnd.gtdcloud.v1" }

  describe "GET #show" do
    before(:each) do
      @account = FactoryGirl.create :account
      get :show, id: @account.id, format: :json
    end

    it "returns the information about a reporter on a hash" do
      account_response = JSON.parse(response.body, symbolize_names: true)
      expect(account_response[:email]).to eql @account.email
    end

    it { should respond_with 200 }
  end

  describe "POST #create" do

    context "when is successfully created" do
      before(:each) do
        @account_attributes = FactoryGirl.attributes_for :account
        post :create, { account: @account_attributes }, format: :json
      end

      it "renders the json representation for the account record just created" do
        account_response = JSON.parse(response.body, symbolize_names: true)
        expect(account_response[:email]).to eql @account_attributes[:email]
      end

      it { should respond_with 201 }
    end

    context "when is not created" do
      before(:each) do
        #notice I'm not including the email
        @invalid_account_attributes = { password: "12345678",
                                     password_confirmation: "12345678" }
        post :create, { account: @invalid_account_attributes }, format: :json
      end

      it "renders an errors json" do
        account_response = JSON.parse(response.body, symbolize_names: true)
        expect(account_response).to have_key(:errors)
      end

      it "renders the json errors on why the account could not be created" do
        account_response = JSON.parse(response.body, symbolize_names: true)
        expect(account_response[:errors][:email]).to include "can't be blank"
      end

      it { should respond_with 422 }
    end
  end
end
