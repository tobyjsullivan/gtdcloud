class Api::V1::AccountsController < ApplicationController
  respond_to :json

  def show
    respond_with Account.find(params[:id])
  end

  def create
    account = Account.new(account_params)
    if account.save
      render json: account, status: 201, location: [:api, account]
    else
      render json: { errors: account.errors }, status: 422
    end
  end

  private

    def account_params
      params.require(:account).permit(:email, :password, :password_confirmation)
    end
end
