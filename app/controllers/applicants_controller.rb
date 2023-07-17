class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.valid?
      # Check if the pet is already associated with an applicant
      if @applicant.pet_id && ApplicantsPet.exists?(pet_id: @applicant.pet_id)
        flash[:error] = 'Pet is already associated with an applicant.'
        redirect_to '/applicants/new'
      else
        @applicant.save
        redirect_to applicant_path(@applicant)
      end
    else
      flash[:error] = 'Invalid data. Please fill out fields correctly.'
      redirect_to '/applicants/new'
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    @matching_pets = params[:pet_name].present? ? Pet.where('name LIKE ?', "%#{params[:pet_name]}%") : []
    @associated_pets = @applicant.pets
  end

  def search
    @applicant = Applicant.find(params[:id])
    @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%")
    render 'search'
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
