class Admin::ApplicationsController < ApplicationController
  def show
    # @application.approve_a_pet
    @application = Application.find(params[:id])
  end

  def update
    # @application.update_pets_approved
    @app_status = ApplicationPet.where("pet_id = ? AND application_id = ?", params[:pet_id], params[:application_id])
    if params[:status] == "approved"
      @app_status.first.update({status: "Approved"})
    else
      @app_status.first.update({status: "Rejected"})
    end

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end
