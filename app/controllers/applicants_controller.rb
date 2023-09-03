class ApplicantsController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end

  def new
  end

  def create
    Applicant.create!(applicant_params)
    #applicant = Applicant.find(params[:id])
    redirect_to "/applicants/#{Applicant.last.id}"
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :application_status)
  end
end