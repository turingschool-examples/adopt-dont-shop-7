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
      flash[:error] = "ERROR invalid data. Please fill out feilds correctly"
      redirect_to "/applicants/new"
      #render :new 
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
    @pet_search = Pet.search(params[:pet_name])
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
