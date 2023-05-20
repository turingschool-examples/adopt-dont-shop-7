class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = ApplicantPet.where(applicant: @applicant.id)
  end

  def new
    # @applicant = Applicant.find(params[:id])
  end

  def create
    @applicant = Applicant.create!(app_params)

    redirect_to "/applicants/#{@applicant.id}"
  end

  private
  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :qualification, :application_status)
  end
end