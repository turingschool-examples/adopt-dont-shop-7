class PetApplicationsController < ApplicationController
  def create
    @pet_applications = PetApplication.create!(pet_application_params)
    redirect_to "/applications/#{@pet_applications.application_id}"
  end

  private
  def pet_application_params
    params.required(:pet_application).permit(:pet_id, :application_id)
  end
end