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

    pet_application.update_pet_status(params[:commit])

    if pet_application.status == "Approved"
      flash[:notice] = "The request to adopt #{pet.name} has been approved!!"
    elsif pet_application.status == "Rejected"
      flash[:notice] = "The request to adopt #{pet.name} has been rejected :("
    else
      flash[:alert] = "There was a problem and #{pet.name}'s adoption has not yet been approved. Please try again later."
    end

    # if pet_application.update!(status: 2)
    #   flash[:notice] = "The request to adopt #{pet.name} has been approved!!"
    # else
    #   flash[:alert] = "There was a problem and #{pet.name}'s adoption has not yet been approved. Please try again later."
    # end
    # if application.pet_applications.all? { |pet_app| pet_app.status == "Approved" }
    
    if @application.all_pets_apps_appr?
      @application.update!(status: "Approved")
    elsif !@application.all_pets_apps_appr?
      @application.update!(status: "Rejected")
    end
  
    redirect_to "/admin/applications/#{@application.id}"
  end

end
