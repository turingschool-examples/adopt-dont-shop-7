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
