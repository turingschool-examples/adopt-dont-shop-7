class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    pet_app = PetApplication.find_by(pet_id: params[:pet_id])
    if params[:commit] == "Approve"
      pet_app.update(adoption_approved: true)
    elsif params[:commit] == "Reject"
      pet_app.update(adoption_approved: false)
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end

