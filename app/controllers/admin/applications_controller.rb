class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find(params[:application_id, pet_id])
  end
end
