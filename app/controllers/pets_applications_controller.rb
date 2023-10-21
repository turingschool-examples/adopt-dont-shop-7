class PetsApplicationsController < ApplicationController
  def update
    # application = Application.find(params[:id])
    # pet = Pet.find(params[:pet_id])
    # application.pets << pet
    # redirect_to "/applications/#{params[:application_id]}"

    application = Application.find(params[:id])
    applicant_pets = application.pets
    
    # applicant_pets.update(applicant_params)
    redirect_to "/applications/#{application.id}"
  end

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end