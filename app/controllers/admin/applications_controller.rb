class Admin::ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    # @application_pets = @application.pets
    #this didn't need to be called if just calling .pets in the view
    # @variable = @application.pet_app_id
    # require 'pry';binding.pry
  end
  
end