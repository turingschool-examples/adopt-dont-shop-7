class ApplicationPetsController < ApplicationController
  def update
    application_pet = ApplicationPet.where(application_id: params[:aid])
# require 'pry'; binding.pry
    redirect_to "/admin/applications/#{params[:aid]}"
  end
end