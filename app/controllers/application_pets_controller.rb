class ApplicationPetsController < ApplicationController

  def create
    @application_pet = ApplicationPet.create(application_pet_params)

    redirect_to show_applications_path(params[:application_id])
  end

  def update
    application_pet = ApplicationPet.find_by("pet_id = ? and application_id = ?", params[:pet_id], params[:id])

    application_pet.update(application_approved: params[:filter])
    Pet.find(params[:pet_id]).update(adoptable: false) if params[:filter]

    redirect_to show_admin_applications_path
  end

  private

  def application_pet_params
    params.permit(:pet_id, :application_id)
  end
end
