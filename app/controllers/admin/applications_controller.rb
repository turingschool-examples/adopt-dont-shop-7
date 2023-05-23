class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    if params[:pet_app_status] == "Approved"
      pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
      pet_application.update(pet_app_status: "Approved")
    else params[:pet_app_status] == "Denied"
      pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
      pet_application.update(pet_app_status: "Denied")
    end
    redirect_to("/admin/applications/#{@application.id}")
  end
end