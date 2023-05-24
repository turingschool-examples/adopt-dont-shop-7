class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pet_applications = PetApplication.find_applications(@application.id)
  end

  def update
    if params[:updated_status] == "Approved"
      pet_application = PetApplication.find(params[:pet_application_id])
      # how to better utilize private params here
      pet_application.update(pet_applications_status: params[:updated_status])
      redirect_to "/admin/applications/#{pet_application.application_id}"
    elsif params[:updated_status] == "Rejected"
      pet_application = PetApplication.find(params[:pet_application_id])
      pet_application.update(pet_applications_status: params[:updated_status])
      redirect_to "/admin/applications/#{pet_application.application_id}"
    end
  end

  ## How and why would you utilize private params here and/or our find_applications class method from PetApplication
  ## When we tried to utilize that it broke EVERYTHING
  # private
  # def application_params
  #   params.permit(
  #     :name,
  #     :street_address,
  #     :city,
  #     :state,
  #     :zip_code,
  #     :description,
  #     :status
  #   )
  # end

  # def pet_application_params
  #   params.permit(
  #     :pet_id,
  #     :application_id,
  #     :pet_applications_status
  #   )
  # end
end