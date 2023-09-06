class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search] == "pet"
      @searched_pets = Pet.where(name: "#{params[:pet_name]}")
    else
      params[:search].present?
      new_search = params[:search]
      @searched_pets = Pet.where("name LIKE ?", "%#{new_search}%")
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
      owner_description: params[:description],
      pets: [],
      status: "In Progress"
    })

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: You must fill in all fields"
      render :new
    end
  end

  def update
    application = Application.find(params[:id])
    application.update({
      status: "Pending",
      pet_description: params[:pet_description]
    })

    redirect_to "/applications/#{application.id}"
  end
end
