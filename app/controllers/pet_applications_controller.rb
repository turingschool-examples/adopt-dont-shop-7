class PetApplicationsController < ApplicationController
  def update
    petapp = PetApplication.find_pet_app(params[:id], params[:pet_id])
    petapp.update(status: "Approved")
    petapp.save

    redirect_to "/admin/applications/#{params[:id]}"
  end
end