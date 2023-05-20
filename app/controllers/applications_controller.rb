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
    new_app = Application.create!(application_params)
    new_app.update(status: "In Progress")
    redirect_to "/applications/#{new_app.id}"
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