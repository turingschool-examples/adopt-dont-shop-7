class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_applications = @application.pet_applications
  end

  def update
    application = Application.find(params[:id])

    application.update(application_params)

    redirect_to "/admin/applications/#{params[:id]}"
  end

  private

  def application_params
    params.permit(
      :id,
      :name,
      :description,
      :street_address,
      :city,
      :state,
      :zip_code,
      :status
    )
  end
end