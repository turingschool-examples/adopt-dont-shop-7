class AdminApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:admin_id])
    @application_pets = @application.application_pets.joins(:pet)
  end

  def update
    application = Application.find(params[:admin_id])
    
    application_pet = ApplicationPet.find(params[:admin_id])
    application_pet.update(status: "Approved")

    redirect_to "/admin/applications/#{application.id}"
  end
end