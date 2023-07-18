class AdminApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
        @pets = @applicant.pets
    end

end