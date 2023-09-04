class ApplicationPetsController < ApplicationController
  def create
    
    require 'pry';binding.pry
    redirect_to "/applications/#{application.id}"
  end

  def update
    status = ApplicationPet.find(params[:id])
    status.update(app_pet_status: params[:app_pet_status])

    redirect_to "/admin/applications/#{status.application_id}"
  end

end