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

  def update
    pet_application = PetApplication.find_pet_application(params[:id], params[:pet_id])
    pet_application.update!(status: params[:status])
    
    application = Application.find(params[:id])
    if application.all_pet_statuses.all?("Approved")
      application.update!({
        status: "Approved"
      })
    elsif application.all_pet_statuses.any?("Rejected")
    application.update!({
      status: "Rejected"
    })
    end 

    redirect_to "/admin/applications/#{params[:id]}"
  end
end