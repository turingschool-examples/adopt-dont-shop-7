class Admin::ApplicationPetsController < ApplicationController

  def update
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    match = ApplicationPet.find_by(pet_id: pet.id, application_id: application.id)
    if params[:approve] == "true"
      match.approve
      pet.approve
      application.change_status
      redirect_to "/admin/applications/#{application.id}"
    else 
      match.reject
      application.change_status
      redirect_to "/admin/applications/#{application.id}"
    end
  end

end