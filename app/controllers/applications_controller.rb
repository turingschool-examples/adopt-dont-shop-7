class ApplicationsController < ApplicationController
  def index
    @application = Application.all
  end

  def show
    @application = Application.find(params[:id])

    if params[:search_by_name].present?
      
      threshold = params[:search_by_name].to_s
      @pets = Pet.where('name = ?', threshold)
      #require 'pry'; binding.pry
    end
  end

  def add_pet_to_application
    
    @application = Application.find(params[:id])
    @adopted_pet = Pet.find(params[:pet_id])
    @application.pets << @adopted_pet
    redirect_to '/applications/:id'
  end

  def new
  end

  def create
    @application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      application_status: params[:application_status]
    })
    
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end
end