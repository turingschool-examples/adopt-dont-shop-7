class PetApplicationsController < ApplicationController

  def create
    applicant = Application.find(params[:id])
    pet_application = PetApplication.create!({
    pet_id: params[:pet_id],
    application_id: params[:id],
    status: "Pending",
    })
  
    redirect_to "/applications/#{applicant.id}"
  end

end