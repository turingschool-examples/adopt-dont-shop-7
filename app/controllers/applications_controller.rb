class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @applicant_pets = @application.pets

    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    else
      @pets = []
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
end