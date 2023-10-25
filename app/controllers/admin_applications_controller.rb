class AdminApplicationsController < ApplicationController
  def show
    # require 'pry'; binding.pry
    @application = Application.find(params[:id])
    @applicant_pets = @application.pets
  end

  def update
    # require 'pry'; binding.pry
    pet_update = PetApplication.find(params[:application_pet_id])
    if params[:value] == "Approved"
      pet_update.update(status: "Approved")
      flash[:notice] = "Approved!"
    else params[:value] == "Rejected" 
      pet_update.update(status: "Rejected")
      flash[:notice] = "Rejected! Sorry."
    end
    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end