class ApplicationPetsController < ApplicationController
  def update
    application = Application.find(params[:id])
    application_pet = ApplicationPet.where("application_id = #{application.id}")
    if params[:approved?] == "Yes"
      application_pet.update(application_pet_status: 2)
      application_pet.pet.update(adoptable: false)
    else
      application_pet.update(application_pet_status: 3)
      application_pet.pet.update(adoptable: true)
    end
    update_application(application)
    redirect_to "/admin/applications/#{application.id}"
  end

  def update_application(application)
    if application.rejected_pets
      application.update(status: 3)
    else application.update(status: 2)
    end
  end
end