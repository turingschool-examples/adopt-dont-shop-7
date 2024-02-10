class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash.now[:notice] = "Error: #{error_message(application.errors)}"
      render :new
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:search].present?
      @pets = Pet.search(params[:search])
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(application_params)
    application.update(status: "Pending")
    redirect_to "/applications/#{application.id}"
  end

  private
  def application_params
    params.permit(
      :name, 
      :street_address, 
      :city, 
      :state, 
      :zip_code, 
      :endorsement,
      :owner_endorsement
      )
  end
end