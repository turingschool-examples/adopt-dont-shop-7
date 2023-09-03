class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @applicant_pets = @applicant.pets
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    else
      @pets = []
    end
    
  end

  def new
  end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to "/applicants/#{Applicant.last.id}"
    else
      flash[:error] = 'Invalid data. Please fill out fields correctly.'
      redirect_to "/applicants/new"
    end
  end

  def update
    applicant = Applicant.find(params[:id])
    applicant.update(applicant_params)
    applicant.update(application_status: "Pending")
    redirect_to "/applicants/#{applicant.id}"
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :application_status)
  end
end