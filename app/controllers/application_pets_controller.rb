class ApplicationPetsController < ApplicationController

  def update
    pet = Pet.find(params[:pet_id])
    application = Application.find(params[:app_id])
    application_pet = ApplicationPet.where("pet_id = '#{pet.id}' and application_id = '#{application.id}'")
    if params[:app_rej] == "approve"
      application_pet.update({
        approved: true,
      })
      # is this restful?
      if application.application_pets.all? { |app_pet| app_pet[:approved] }
        application.update({
          status: "Approved"
        })
        Pet.update_adoptable(application.id)
      end
    elsif params[:app_rej] == "reject"
      application_pet.update({
        rejected: true,
        })
      if application.application_pets.any? { |app_pet| app_pet[:rejected] }
        application.update({
          status: "Rejected"
        })
      end
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end