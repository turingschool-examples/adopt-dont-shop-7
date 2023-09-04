class ApplicantsController < ApplicationController
  def index

  end
  
  def show
    @applicant = Applicant.find(params[:id])
    # @pets = Pet.find(params[:id])
  end

  def new

  end

  def create
  # require 'pry';binding.pry
    applicant = Applicant.new(applicant_params)
    if applicant.save
      redirect_to "/applicants/#{applicant.id}"
    else
      flash[:alert] = "Application not created: Required information missing."
      render :new
    end
  end

  private
  def applicant_params
    params.permit(:id, :name, :street_address, :city, :state, :zipcode, :description, status: :InProgress)
  end
end