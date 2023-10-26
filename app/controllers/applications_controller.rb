class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill in all required fields"
      # flash[:alert] = "Error: #{error_message(@application.errors)}"
      redirect_to "/applications/new"
      # render :new
    end
  end
  
  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pet = @application.search(params[:name])
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end