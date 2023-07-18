class AdminController < ApplicationController
  def index
    @shelters = Shelter.reverse_alpha
    @shelters_with_pending_applications = Shelter.pending_applications
  end
  
  def show
    @application = Application.includes(:pets).find(params[:id])
    # @application_pets = ApplicationPet.includes(:pet).where(params[:application_pet_id])
    @application_pets = @application.application_pets.includes(:pet)
  end

  def update
    application_pet = ApplicationPet.find(params[:application_pet_id])
    if params[:reject].to_s == "true"
      application_pet.update(status: "Rejected")
    else
      application_pet.update(status: "Approved")
    end
      redirect_to "/admin/applications/#{application_pet.application.id}"
  end
end