class AdminApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:application_id])
  end

  def update
    application_pet = ApplicationPet.find(params[:application_pet_id])
    application_pet.update(status: "Approved")

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end