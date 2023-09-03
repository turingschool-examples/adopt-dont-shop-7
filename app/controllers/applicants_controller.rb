class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    if params[:pet_name].present?
      @pets = Pet.search(params[:pet_name])
    else
      @pets = @applicant.pets
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

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :application_status)
  end
end