class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.matching_applications(@application)
  end

  def new
  end
  
  def create
      application = Application.new(application_params)
      if application.save
        redirect_to "/applications/#{application.id}"
      else
        flash[:alert] = "Error: #{error_message(application.errors)}"
        redirect_to "/applications/new"
      end
  end

  def search
    show
    @query = Pet.query(params[:search])
  end

  def update
    show
    @application.update(application_status: "Pending")
    redirect_to "/applications/#{@application.id}"
  end

  def admin_show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.matching_applications(@application)
  end

  def admin_patch
    @application = Application.find(params[:id])
    @application.update(application_status: params[:status])
    redirect_to "/admin/applications/#{@application.id}"
  end

  private
  def application_params

    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end

