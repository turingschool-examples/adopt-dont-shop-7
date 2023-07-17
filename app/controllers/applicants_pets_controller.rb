class ApplicantsPetsController < ApplicationController
  def create
    @applicant = Applicant.find(params[:applicant_id])
    @pet = Pet.find(params[:pet_id])

    # Check if the pet is already associated with the applicant
    if @applicant.pets.exists?(@pet.id)
      flash[:error] = 'Pet is already associated with the applicant.'
    else
      @applicant.pets << @pet
    end

    redirect_to applicant_path(@applicant)
  end
end
