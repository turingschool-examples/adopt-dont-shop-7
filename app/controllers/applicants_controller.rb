class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.valid?
      @applicant.save
      redirect_to applicant_path(@applicant)
    else
      flash[:error] = 'ERROR invalid data. Please fill out feilds correctly'
      redirect_to '/applicants/new'
      # render :new
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
