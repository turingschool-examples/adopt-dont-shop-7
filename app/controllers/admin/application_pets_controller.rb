class Admin::ApplicationPetsController < ApplicationController
  def update
    @application_pet = ApplicationPet.where("pet_id = ? AND application_id = ?", params[:pet_id], params[:application_id])
    if params[:status] == "approved"
      @application_pet.applications.first.update({status: "Approved"})
    else
      @application_pet.applications.first.update({status: "Rejected"})
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
