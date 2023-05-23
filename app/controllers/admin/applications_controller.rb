class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @application = Application.find(params[:id])
    pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id])
    pet_application.update(pet_app_status: "Approved")
    redirect_to("/admin/applications/#{@application.id}")
  end
end