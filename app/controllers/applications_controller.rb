class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets

    if params[:pet_name].present? 
      pet_name = params[:pet_name]
      @search_pets = Pet.where("name ILIKE ?", "%#{pet_name}%")
    else 
      @search_pets = []
    end
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
      status: "In Progress"
    })

    if @application.save
      redirect_to "/applications/#{@application.id}"
    else 
      flash[:alert] = "Please Fill In All Fields"
      redirect_to "/applications/new"
    end
  end

  def update 
    application = Application.find(params[:id])
    application.pets.update({name: params[:pet_name]})
    redirect_to "/applications/#{application.id}"
  end
end