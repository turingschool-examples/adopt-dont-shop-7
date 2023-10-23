class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.adoptable.search(params[:search])
    end
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

  def update
    application = Application.find(params[:id])

    if params[:pet_id].present?
      application.pets << Pet.find(params[:pet_id])
      redirect_to "/applications/#{application.id}"   
    end

    if params[:status_update].present? && params[:add_qualifications].present?
      application.update(status: params[:status_update], qualifications: params[:add_qualifications])
      redirect_to "/applications/#{application.id}"   
    end

  end

  private
    def application_params
      params.permit(:name, :street, :city, :state, :zip, :description, :status)
    end
 
end
