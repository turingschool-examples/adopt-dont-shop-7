class Admin::PetApplicationsController < ApplicationController
    def update
        pet_application = PetApplication.where(["application_id = ? and pet_id = ?", "#{params[:id]}", "#{params[:pet_id]}"])
        if params[:button] == "approve"
            pet_application.update(
            application_status: "Approved"
            )
        elsif params[:button] == "reject"
            pet_application.update(
            application_status: "Rejected"
            )
        end
    # require 'pry';binding.pry
        redirect_to "/admin/applications/#{params[:id]}"
    end
end