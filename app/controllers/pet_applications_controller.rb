class PetApplicationsController < ApplicationController
  def create 
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:format]) 

    unless @application.pets.include?(@pet)
      @application.pets << @pet 
    end

    redirect_to "/applications/#{params[:id]}" 
  end
end