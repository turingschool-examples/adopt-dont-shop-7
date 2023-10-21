class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:search] == "pet" && params[:pet_name].present? 
      pet_name = params[:pet_name]
      @search_pets = Pet.where("name ILIKE ?", "%#{pet_name}%")
    else 
      @search_pets = []
    end
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

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:error] = "Please fill in all required fields." 
      redirect_to "/applications/new"
    end
  end

  def update 
    application = Application.find(params[:application_id])
    pet = Pet.find(params[:pet_id])
    application.pets << pet
    redirect_to "/applications/#{@application_id}"
  end
end