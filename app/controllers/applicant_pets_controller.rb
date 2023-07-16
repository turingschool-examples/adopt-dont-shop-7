class ApplicantPetsController < ApplicationController

    def create
        @applicant_pets = ApplicantPet.create(app_pet_params)
    end

    private

    def app_pet_params
        params.permit(:applicant_id, :pet_id)
    end
end
