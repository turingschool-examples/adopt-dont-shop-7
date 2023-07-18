class ApplicationPetsController < ApplicationController
  def create
    link = ApplicationPet.create!(pet_id: params[:pet_id], application_id: params[:application_id])
    redirect_to "/applications/#{link.application_id}"
  end
  def update #approve pet for application
    
  end

end