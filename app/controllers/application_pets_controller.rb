class ApplicationPetsController < ApplicationController
  # require 'pry'; binding.pry
  def create 
    ApplicationPet.create(application_id: params[:id],pet_id: params[:pet_id])
    # require 'pry'; binding.pry

    redirect_to "/applications/#{params[:id]}"
  end


end

