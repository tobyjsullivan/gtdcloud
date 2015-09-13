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
end
