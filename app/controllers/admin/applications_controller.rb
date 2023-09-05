class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    @pet_application = PetApplication.find(params[:id])

    @pet_application.approve
    @application = @pet_application.application
    redirect_to "/admin/applications/#{@application.id}"
  end
end