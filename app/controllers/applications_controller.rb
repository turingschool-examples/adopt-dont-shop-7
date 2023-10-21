class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @application_pets = @application.pets
    @pets = []
    
    if params[:search].present?
      @pets = Pet.search(params[:search])
      # require 'pry';binding.pry
    end
  end

  def new
  end

  def create
    application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      status: "In Progress"
    })
    if application.save 
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end

  end
end
