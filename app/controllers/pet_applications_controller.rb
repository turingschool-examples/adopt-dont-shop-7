class PetApplicationsController < ApplicationController
  def update
    petapp = PetApplication.find_pet_app(params[:id], params[:pet_id])
    
    if params[:status] == "approved"
      petapp.update(status: "Approved")
    else
      petapp.update(status: "Rejected")
    end
    
    petapp.save

    redirect_to "/admin/applications/#{params[:id]}"
  end
end