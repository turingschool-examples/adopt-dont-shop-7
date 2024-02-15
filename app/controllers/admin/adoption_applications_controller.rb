class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @adoption_app = AdoptionApplication.find(params[:id])
        @app_pets = @adoption_app.pets
        @pets = Pet.search(params[:search])

        if params[:approved_pet].present?
            pet_id = params[:approved_pet]
            AdoptionApplicationPet.change_status_to_approved(@adoption_app.id, pet_id)
            @adoption_app.change_app_status("Approved")
        end

        if params[:rejected_pet].present?
            pet_id = params[:rejected_pet]
            AdoptionApplicationPet.change_status_to_rejected(@adoption_app.id, pet_id)
            @adoption_app.change_app_status("Rejected")
        end
    end    
end


