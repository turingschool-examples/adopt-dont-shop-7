class PetApplicationsController < ApplicationController

  def create
    application = Application.find(params[:app_id])

    PetApplication.create!({
        pet_id: params[:pet_id],
        application_id: application.id
      })
      
    redirect_to "/applications/#{application.id}"
  end


end
