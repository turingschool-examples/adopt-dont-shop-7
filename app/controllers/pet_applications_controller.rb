class PetApplicationsController < ApplicationController

  def create
    application = Application.find(params[:app_id])

    PetApplication.create!({
        pet_id: params[:pet_id],
        application_id: application.id
      })
      
    redirect_to "/applications/#{application.id}"
  end

  def update 
    application = Application.find(params[:app_id])
    pet = Pet.find(params[:pet_id])
    pet_application = PetApplication.find_pet_app(pet.id, application.id)

    if pet_application.update!(status: 2)
      flash[:notice] = "The request to adopt #{Pet.find(params[:pet_id]).name} has been approved!!"
    else
      flash[:alert] = "There was a problem and #{Pet.find(params[:pet_id]).name}'s adoption has not yet been approved. Please try again later."
    end
    
    redirect_to "/admin/applications/#{application.id}"
  end

end
