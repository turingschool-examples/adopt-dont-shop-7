class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    # @tables = ApplicationPet.find(params[:id])
  end
end