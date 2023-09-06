class PetApplicantsController < ApplicationController
  def index
  end

  def create
    PetApplicant.create!(pet: Pet.find(params[:pet]), applicant: Applicant.find(params[:id]))
    redirect_to "/applicants/#{params[:id]}"
  end
end