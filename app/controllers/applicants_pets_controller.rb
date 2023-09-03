class ApplicantsPetsController < ApplicationController

  def update
    applicant = Applicant.find(params[:applicant_id])
    pet = Pet.find(params[:pet_id])
    applicant.pets << pet

    redirect_to "/applicants/#{params[:applicant_id]}"
  end

end