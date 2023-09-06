class Admin::ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
    @applicant_pets = @applicant.pets
   
  end

  def approve_pet
    #require 'pry'; binding.pry
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])
    @applicants_pet = ApplicantsPet.find_by(params[applicant_id: @applicant.id, pet_id: @pet.id])
    @applicants_pet.update(status: 'Approved')
    redirect_to "/admin/applications/#{@applicant.id}"
  end


end
