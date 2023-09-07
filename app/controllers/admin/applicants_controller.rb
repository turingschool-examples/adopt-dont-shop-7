class Admin::ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.where(application_status: "Pending")
  end
  
  def show
    @applicant = Applicant.find(params[:id])
    @applicant_pets = @applicant.pets
  end

  def approve_pet
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])
    @applicants_pet = ApplicantsPet.find_by(params[applicant_id: @applicant.id, pet_id: @pet.id])
    @applicants_pet.update(status: 'Approved')
    redirect_to "/admin/applications/#{@applicant.id}"
  end

  def reject_pet
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])
    @applicants_pet = ApplicantsPet.find_by(params[applicant_id: @applicant.id, pet_id: @pet.id])
    @applicants_pet.update(status: 'Rejected')
    redirect_to "/admin/applications/#{@applicant.id}"
  end


end
