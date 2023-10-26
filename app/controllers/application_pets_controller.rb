class ApplicationPetsController < ApplicationController
  def update
    application = Application.find(params[:id])
    selected_app_pet = ApplicationPet.find(params[:pet_id])
    if params[:approved?] == "Yes"
      selected_app_pet.update(application_pet_status: 2)
      selected_app_pet.update(adoptable: false)
    else
      selected_app_pet.update(application_pet_status: 3)
      selected_app_pet.pet.update(adoptable: true)
    end
    update_application(application)
    redirect_to "/admin/applications/#{application.id}"
  end

  def update_application(application)
    application = Application.find(params[:id])
    application_pets = application.application_pets
    if application.has_rejected_pets
      application.update(status: 3)
    elsif application.has_pending_pets
      application.update(status: 1)
    else 
      application.update(status: 2)
    end
  end
end