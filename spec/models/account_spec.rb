require 'spec_helper'

describe Account do
  before { @account = FactoryGirl.build(:account) }

  subject { @account }

  it { should respond_to(:email) }
  it { should respond_to(:password) }
  it { should respond_to(:password_confirmation) }

  it { should be_valid }
end
