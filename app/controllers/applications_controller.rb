class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)
      if application.valid?
        application.update(status: 'In Progress')
        redirect_to "/applications/#{application.id}"

      else
        flash[:alert] = "Error: #{error_message(application.errors)}"
        redirect_to "/applications/new"
      end
  end
  
private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end