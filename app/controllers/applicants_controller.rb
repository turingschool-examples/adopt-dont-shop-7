class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @pets = ApplicantPet.where(applicant: @applicant.id)
  end
end