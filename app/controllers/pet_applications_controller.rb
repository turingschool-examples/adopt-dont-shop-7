class PetApplicationsController < ApplicationController
  def create
    PetApplication.create!(pet: Pet.find(params[:pet]), application: Application.find(params[:id]))
    redirect_to "/applications/#{params[:id]}"
  end
end