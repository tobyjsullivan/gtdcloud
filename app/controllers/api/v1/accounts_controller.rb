class Api::V1::AccountsController < ApplicationController
  respond_to :json

  def show
    respond_with Account.find(params[:id])
  end
end
