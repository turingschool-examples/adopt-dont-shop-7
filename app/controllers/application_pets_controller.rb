class ApplicationPetsController < ApplicationController
  
  def update
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])

    # needed to update this because it was causing other tests to fail
    unless @application.pets.include?(@pet)
      @application.pets << @pet
    end
      redirect_to "/applications/#{@application.id}"
  end
end
