class AdminApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    require'pry';binding.pry
    @application = Application.find(params[:id])
    @pet_application = PetApplication.find(params[:pet_app_id])

    if params[:status] == "approved"
      @pet_application.update(app_status: "approved")
    elsif params[:status] == "rejected"
      @pet_application.update(app_status: "rejected")
    end

    redirect_to "/admin/applications/#{@application.id}"
  end
end