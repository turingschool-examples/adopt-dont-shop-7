class Admin::ApplicationPetsController < ApplicationController


  def update
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    match = ApplicationPet.find_by(pet_id: pet.id, application_id: application.id)
    match.update(status: true)
    pet.update(adoptable: false)
    redirect_to "/admin/applications/#{application.id}"
  end

end