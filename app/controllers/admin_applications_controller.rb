class AdminApplicationsController < ApplicationController
  def show
    @admin_application = Application.find(params[:app_id])
  end

  def update
    pet_update = PetApplication.find(params[:application_pet_id])
    if params[:value] == "Approved"
      pet_update.update(status: "Approved")
    else params[:value] == "Rejected"
      pet_update.update(status: "Rejected")
    end
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end