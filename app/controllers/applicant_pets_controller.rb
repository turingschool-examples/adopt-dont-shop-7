class ApplicantPetsController < ApplicationController
  def create
    applicant = Applicant.find(params[:applicant_id])
    applicant_pet = ApplicantPet.create!(app_pet_params)
    redirect_to "/applicants/#{applicant.id}"
  end

  private
  def app_pet_params
    params.permit(:applicant_id, :pet_id)
  end
end