class Admin::ApplicationPetsController < ApplicationController
  def approve
    application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    application_pet.approve

    redirect_to "/admin/applications/#{application_pet.application.id}"
  end

  def reject
    application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    application_pet.reject

    redirect_to "/admin/applications/#{application_pet.application.id}"
  end
end
