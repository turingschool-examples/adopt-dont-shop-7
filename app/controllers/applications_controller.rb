class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search].present?
      @results = Pet.search(params[:search])
      @search = params[:search]
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
    zipcode: params[:zipcode],
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