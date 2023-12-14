class Admin::ApplicationsController < ApplicationController
    def show
        @application = Application.find(params[:id])
        
        @pets = Pet.search(params[:search])
        
        if params[:added_pet].present? 
            pet_id = params[:added_pet]
            @application.add_pet_to_application(pet_id)
        end

        if params[:pet_ownership_description].present?
            @application.change_application_status("Pending")
        end

        if params[:approved_pet_id].present?
            pet_id = params[:approved_pet_id]
            application_pet = ApplicationPet.where({pet_id: pet_id,application_id: @application.id}).first
            application_pet.change_application_pet_status("Approved")
        end

        if params[:rejected_pet_id].present?
            pet_id = params[:rejected_pet_id]
            application_pet = ApplicationPet.where({pet_id: pet_id,application_id: @application.id}).first
            application_pet.change_application_pet_status("Rejected")
        end
    end
end