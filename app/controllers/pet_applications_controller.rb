class PetApplicationsController < ApplicationController
  def create
    pet_adopt = PetApplication.new(application_id: params[:application_id], pet_id: params[:pet_id])
    if pet_adopt.save
      redirect_to "/applications/#{params[:application_id]}"
    # else
    #   redirect_to "/applications/#{params[:application_id]}"
    #   # flash[:alert] = "Error: #{error_message(pet_adopt.errors)}"
    end
  end
end
