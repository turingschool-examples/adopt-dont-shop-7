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
  def update_adoption_description
    @applicants_pet = ApplicantsPets.find(params[:id])
    if @applicants_pet.update(applicants_pet_params)
      redirect_to @applicants_pet.applicant, notice: "description successfully updated"
    else 
      render :edit  
    end
  end
private 
def applicants_pet_params
  params.require(:applicants_pet).permit(:adoption_description)
end
end
