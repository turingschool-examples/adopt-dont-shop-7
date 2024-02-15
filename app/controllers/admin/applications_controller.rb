class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  # def check_approval(pet)
  #   pet.application_pets.where(pet_status: "approved").any?
  # end
end
