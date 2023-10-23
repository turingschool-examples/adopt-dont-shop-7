class ApplicationsController < ApplicationController
  def index
    @application = Application.all

  def new
  end

  def show
    @application = Application.find(params[:id])
    @pets = Application.select("pets.name").joins(:pets).pluck(:name)
    
    if params[:search_by_name].present?
      threshold = params[:search_by_name].to_s
      @pets = @pets.where('name = ?', threshold)
    end
  end

  def add_pet_to_application
    @application = Application.find(params[:id])
    @adopted_pet = Pet.find(params[:pet_id])
    @application.pet = @adopted_pet.name
    redirect_to '/applications/:id'
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