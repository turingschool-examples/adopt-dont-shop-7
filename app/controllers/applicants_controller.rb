class ApplicantsController < ApplicationController
    def show
        @applicant = Applicant.find(params[:id])
        @pets = @applicant.pets
        @pet_search = Pet.adoptable.where(name: params[:search])
    end

    def new

    end

    def create
        @applicant = Applicant.new(applicant_params)
        if @applicant.save
            redirect_to "/applicants/#{@applicant.id}"
        else
            redirect_to "/applicants/new"
            flash[:alert] = "ERROR: Form incomplete, please fill out missing information"
        end
    end


    private
    def applicant_params
        params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
    end
end