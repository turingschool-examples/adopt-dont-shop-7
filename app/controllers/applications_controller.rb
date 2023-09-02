class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new
  end

  def create
    application = Application.new({

    name: params[:name], 
    street_address: params[:street_address], 
    city: params[:city], 
    state: params[:state],
    zipcode: params[:zipcode],
    description: params[:description],
    status: "In Progress"
    })
    application.save

    redirect_to "/applications/#{application.id}"
  end
end