class ApplicationPetsController < ApplicationController
  def create
    @application = Application.find(params[:application_id])
    @pet = Pet.find(params[:pet_id])

    @application.pets << @pet

    redirect_to "/applications/#{@application.id}"

    # @pet_application = ApplicationPet.new(pet_application_params)
    # @pet_application.save
    # redirect_to "/applications/#{@application.id}"
    
  end
end
