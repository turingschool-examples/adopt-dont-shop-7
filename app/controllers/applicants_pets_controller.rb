class ApplicantsPetsController < ApplicationController
  def create
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])
    @applicant.pets << @pet
    redirect_to applicant_path(@applicant)
  end
end
