class ApplicationPetsController < ApplicationController
  
  def new
  end

  def create
    @application_pet = ApplicationPet.new(application_pets_params)
    @application_pet.save
    redirect_to "/applications/#{@application_pet.application_id}"
  end

  def update
    if params[:status] == "approve"
      application_pet = ApplicationPet.find(params[:id])
      application_pet.update(status: "Approved")
    elsif params[:status] == "reject"
      application_pet = ApplicationPet.find(params[:id])
      application_pet.update(status: "Rejected")
    end
    redirect_to "/admin/applications/#{params[:application_id]}"
  end

  private
  def application_pets_params
    params.permit(:application_id, :pet_id)
  end
end