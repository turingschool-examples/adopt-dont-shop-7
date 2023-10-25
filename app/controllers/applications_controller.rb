class ApplicationsController < ApplicationController
  def new
  end
  
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
    if params[:search].present?
      @searched = Pet.search_for_pet(params[:search])
    end
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
    @application = Application.find(params[:application_id])
    if params[:pet_id].present?
      selected_pet = Pet.find(params[:pet_id])
      @application.add_pet(selected_pet)
    elsif params[:reason].present?
      @application.update(status: 1)
    end
    redirect_to "/applications/#{@application.id}"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
