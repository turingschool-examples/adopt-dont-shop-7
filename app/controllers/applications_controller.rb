class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @application.status = 'In Progress' if params[:commit] == 'Submit'
    @pets_search = Pet.search(params[:pet_name]) if params[:pet_name].present?
  end

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
