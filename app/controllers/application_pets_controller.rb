class ApplicationPetsController < ApplicationController
  def index

  end

  def new

  end

  def create
  @application_pet = ApplicationPet.create(application_pet_params)

    redirect_to show_application_path
  end

  def edit

  end

  def update
    application_pet = ApplicationPet.where("pet_id = ? and application_id = ?", params[:pet_id], params[:id])

    if params[:filter] == "approved"
      application_pet.update(application_approved: true)
    else
      application_pet.update(application_approved: false)
    end

    redirect_to show_admin_applications_path
  end

  def show

  end

  def destroy

  end

  private

  def application_pet_params
    params.permit(:pet_id, :application_id)
  end
end
