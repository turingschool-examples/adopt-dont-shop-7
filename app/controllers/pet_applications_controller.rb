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
    @application = Application.find(params[:app_id])
    pet = Pet.find(params[:pet_id])
    pet_application = @application.get_pet_app(pet.id)

    
    # TODO: can we test call to update!
    #    i.e. if pet_application.update!({pet_id: pet.id, application_id: @application.id})
    #           "Your update was successful and the change has been processed..."
    #         else  
    #           "There was a problem and we could not make the update you requested..."
    #         end

    pet_application.update_pet_status(params[:commit])

    if pet_application.status == "Approved"
      flash[:notice] = "The request to adopt #{pet.name} has been approved!!"
    elsif pet_application.status == "Rejected"
      flash[:notice] = "The request to adopt #{pet.name} has been rejected :("
    else
      flash[:alert] = "There was a problem and #{pet.name}'s adoption has not yet been approved. Please try again later."
    end
    
    if @application.get_app_status == "Approved"
      @application.update!(status: "Approved")
    elsif @application.get_app_status == "Rejected" 
      @application.update!(status: "Rejected")
    else
      @application.update!(status: "Pending")
    end

    redirect_to "/admin/applications/#{@application.id}"
  end

end
