class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def create
    puts "Received params: #{params.inspect}"
    @applicant = Applicant.new(applicant_params)

    if @applicant.save
      redirect_to applicant_path(@applicant)
    else
      flash[:error] = 'Invalid data. Please fill out fields correctly.'
      redirect_to new_applicant_path
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%")
    @associated_pets = @applicant.pets
    @applicants_pet = ApplicantsPet.find_or_initialize_by(applicant: @applicant)
  end

  def search
    @applicant = Applicant.find(params[:id])
    @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%")
    render 'search'
  end

  private

  def applicant_params
    params.require(:applicant).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
