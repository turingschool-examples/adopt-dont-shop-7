class ApplicantController < ApplicationController
    def index
        @applicant = Applicant.all
    end
    
    def show
        @applicant = Applicant.find(params[:id])
    end
end