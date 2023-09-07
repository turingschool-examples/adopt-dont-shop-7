class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find(params[:id])
    @application = @pet_application.application
    @pet = @pet_application.pet

    if params[:commit] == 'Approve'
      @pet_application.approve
    elsif params[:commit] == 'Reject'
      @pet_application.reject
    end

    @application.update_status
    @pet.update_adoptable_status

    redirect_to admin_application_path(@application)
  end
end