class AdminsController < ApplicationController
  def index
    @shelters = Shelter.reverse_alphabetical_name
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    pet_applications = PetApplication.where(application_id: params[:id], pet_id: params[:petid])
    pet_applications.update({
      status: "Approved"
    })

    pet_applications.first.save
    redirect_to "/admin/applications/#{params[:id]}"
  end
end