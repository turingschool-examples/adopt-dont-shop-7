class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
        @pets = @applicant.pets
    end

    def update
        @applicant = Applicant.find(params[:id])
        applicant_pet = @applicant.pet_app_status(params[:pet_id])
        if params[:commit] == "Accept"
            applicant_pet.update(status: params[:commit])
            redirect_to "/admin/applicants/#{@applicant.id}"
        elsif params[:commit] == "Reject"
            applicant_pet.update(status: params[:commit])
            redirect_to "/admin/applicants/#{@applicant.id}"
        end
    end
end