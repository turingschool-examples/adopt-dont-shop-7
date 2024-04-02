class Admin::PetApplicationsController < ApplicationController
  def update
    pet_application = PetApplication.find(params[:id])

    pet_application.update(status: "#{params[:status]}")

    redirect_to "/admin/applications/#{params[:application_id]}"
  end
end