class ApplicantPetsController < ApplicationController

    def create
        @applicant_pets = ApplicantPet.create(app_pet_params)
    end

    private

    def app_pet_params
        params.permit(params: [:pet_id, :applicant_id])
    end
end