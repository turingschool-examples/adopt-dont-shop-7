class ApplicantsController < ApplicationController
  def index
    @applicants = Applicant.all
  end

  def new; end

  def create
    @applicant = Applicant.new(applicant_params)
    if @applicant.save
      redirect_to applicant_path(@applicant)
    else
      render :new
    end
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
