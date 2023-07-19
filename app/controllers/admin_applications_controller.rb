class AdminApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:application_id])
  end

  def update
    application_pet = ApplicationPet.find(params[:application_pet_id])

    if params[:commit] == "Approve"
      application_pet.update(status: "Approved")
    elsif params[:commit] == "Reject"
      application_pet.update(status: "Rejected")
    end
    
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
  
end