class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  
    @pets = Pet.joins(:applications).where(applications: {id: @application.id})
    
    @status = ApplicationPet.where(application_id: "#{@application.id}")
  end

  def approve_all_pets
    @application = Application.find(params[:id])

    @application.pets.each do |pet|
      pet_status = ApplicationPet.find_by(application_id: @application.id, pet_id: pet.id)
      pet_status.update(app_pet_status: "approved")
    end
    
    @application.update(application_status: "Approved")

    redirect_to "/applications/#{@application.id}"
  end
end