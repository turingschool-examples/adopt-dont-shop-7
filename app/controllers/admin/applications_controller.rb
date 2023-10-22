class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    
    if params[:commit] == "Approve"
      application.update(status: "Approved")
    elsif params[:commit] == "Reject"
      application.update(status: "Rejected")
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end

Pet.joins(:applications).where("application_id = 1").pluck(:status)