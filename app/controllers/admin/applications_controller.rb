class Admin::ApplicationsController < ApplicationController
  def show
    # require 'pry'; binding.pry
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    @app_petapp = @application.pet_applications
    # require 'pry'; binding.pry
  end
end