class AdminApplicationsController < ApplicationController
  def show
    @admin_application = Application.find(params[:app_id])
  end

  def update
    pet_update = PetApplication.find(params[:application_pet_id])
    if pet_update.update
      redirect_to "/admin/applications/#{@application_1.id}"
    end
  end
end