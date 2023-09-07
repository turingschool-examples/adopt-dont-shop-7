class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
  end

  def update
    pet_update = PetApplication.find(params[:application_pet_id])
    if params[:value] == "Approved"
      pet_update.update(status: "Approved")
      flash[:notice] = "This pet has been APPROVED for adoption. Congrats!"
    else params[:value] == "Rejected"
      pet_update.update(status: "Rejected")
      flash[:notice] = "This pet has been REJECTED for adoption. Sorry."
    end
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end