class ApplicationPetsController < ApplicationController
  def new
    ApplicationPet.create!(pet_id: params[:pet_id], application_id: params[:id])
    redirect_to "/applications/#{params[:id]}"
  end
end