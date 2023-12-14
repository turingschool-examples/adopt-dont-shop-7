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

    if @application.all_pets_apps_appr?
      @application.update!(status: "Approved")
      flash[:notice] = "The request to adopt #{pet.name} has been approved!!"
    elsif !@application.all_pets_apps_appr?
      @application.update!(status: "Rejected")
      flash[:notice] = "The request to adopt #{pet.name} has been rejected :("
    end
    redirect_to "/admin/applications/#{@application.id}"
  end
end
