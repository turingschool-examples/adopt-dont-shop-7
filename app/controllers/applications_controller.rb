class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
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
      flash[:alert] = "Error: Fill in all fields"
      redirect_to "/applications/new"

    end
  end

  # private

  # def app_params
  #   params.permit(:id, :name, :street_address, :city, :state, :zip_code, :description, status: "In Progress")
  # end
end
