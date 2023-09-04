class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    if params[:button] == "approve"
      application.update(
        status: "Approved"
      )
    elsif params[:button] == "reject"
      application.update(
        status: "Rejected"
      )
    end

    redirect_to "/admin/applications/#{application.id}"
  end
end