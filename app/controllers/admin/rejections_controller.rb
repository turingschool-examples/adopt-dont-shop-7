class Admin::RejectionsController < ApplicationController
  def create
    application_pet = ApplicationPet.find_by(application_id: params[:id], pet_id: params[:pet_id])
    application_pet.reject

    redirect_to "/admin/applications/#{application_pet.application.id}"
  end
end
