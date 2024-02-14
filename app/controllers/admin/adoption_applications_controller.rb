class Admin::AdoptionApplicationsController < ApplicationController

    def show
        @adoption_app = AdoptionApplication.find(params[:id])
        @app_pets = @adoption_app.pets
        @pets = Pet.search(params[:search])

        # We want to change the application status rather than if the pet is adoptable, user story 14 requires pet to be still visible
        if params[:approved_pet].present?
            pet_id = params[:approved_pet]
            adoption_app_pet = AdoptionApplicationPet.where({pet_id: pet_id,adoption_application_id: @adoption_app.id}).first
            adoption_app_pet.change_app_pet_status("Approved")
        end

        # Reject the application if the pet is rejected. That way we can display different messages in the show page if the pet is approved or rejected
        if params[:rejected_pet].present?
            pet_id = params[:rejected_pet]
            adoption_app_pet = AdoptionApplicationPet.where({pet_id: pet_id,adoption_application_id: @adoption_app.id}).first
            adoption_app_pet.change_app_pet_status("Rejected")
        end
    end    
end


