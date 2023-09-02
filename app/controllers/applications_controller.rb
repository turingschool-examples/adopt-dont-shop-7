class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    application = Application.create({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      status: "In Progress"
    })

    if application.new_record? == true
      flash.alert = "All Fields Must be Filled"
      redirect_to "/applications/new"
    else
      redirect_to "/applications/#{application.id}"
    end
  end
end