class Admin::ApprovalsController < ApplicationController
  def create
    application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    application_pet.approve

    redirect_to "/admin/applications/#{application_pet.application.id}"
  end
end
