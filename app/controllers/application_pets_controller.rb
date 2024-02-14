class ApplicationPetsController < ApplicationController

  def create
    @application_pet = ApplicationPet.create(application_pet_params)

    redirect_to show_applications_path(params[:application_id])
  end

  def update
    application_pet = ApplicationPet.find(params[:id])
    application_pet.update(application_pet_params)


    redirect_to show_admin_applications_path(params[:application_id])
  end

  private

  def application_pet_params
    params.permit(:pet_id,
                  :application_id,
                  :application_approved,
                  :application_reviewed)
  end
end
