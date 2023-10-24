class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    pet = Pet.find(params[:pet_id])
    pet_app = pet.pet_applications
    if params[:commit] == "Approve"
      pet_app.update(adoption_approved: true)
    elsif params[:commit] == "Reject"
      pet_app.update(adoption_approved: false)
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end

