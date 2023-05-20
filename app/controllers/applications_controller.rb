class ApplicationsController < ApplicationController
  def index

  end

  def show
    @application = Application.find(params[:id])
    @app_petapps = PetApplication.find_applications(@application.id)
  end

  def new

  end

  def create
    new_app = Application.new(application_params)
    if new_app.save
      new_app.update(status: "In Progress")
      redirect_to "/applications/#{new_app.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(new_app.errors)}"
    end
  end

  private

  def application_params
    params.permit(
      :name,
      :street_address,
      :city,
      :state,
      :zip_code,
      :description,
      :status
    )
  end
end