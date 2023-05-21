class PetApplicationsController < ApplicationController

  def create

    @application = Application.find(params[:id])
    @pet = Pet.find_by(name: params[:search])
    PetApplication.create!(application: @application, pet: @pet)

    redirect_to "/applications/#{@application.id}"
  end





end