class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def add_pet
    @application = Application.find(params[:id])
    pet = Pet.find_by(name: params[:pet_name])

    if pet
      unless @application.pets.include?(pet)
        @application.pets << pet
      end
    end

    redirect_to "/applications/#{params[:id]}"
  end  
end

