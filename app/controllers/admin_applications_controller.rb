class AdminApplicationsController < ApplicationsController
  def show
    @application = Application.find(params[:application_id])
  end

  def update
    application = Application.find(params[:application_id])
    application.update(status: "Approved")

    redirect_to "/admin/applications/#{application.id}"
  end
end