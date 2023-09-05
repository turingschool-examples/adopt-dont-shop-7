class PetApplicationsController < ApplicationController
    def create
        applicant = Application.find(params[:id])
        petapp = PetApplication.create!(
            pet_id: params[:pet_id],
            application_id: params[:id],
            application_status: "Pending"
            )
        redirect_to "/applications/#{applicant.id}"
    end
end