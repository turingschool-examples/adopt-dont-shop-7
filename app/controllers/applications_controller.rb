class ApplicationsController < ApplicationController
  def index
    @num_of_applications = Application.all.num_of_applications
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    @application = Application.create!(
      name: params[:name],
      street_address: params[:street_address], 
      city: params[:city], 
      state: params[:state], 
      zip_code: params[:zip_code], 
      adopting_reason: params[:description], 
      status: "In Progress", 
      )
    redirect_to "/applications/#{@application.id}"
  end
end