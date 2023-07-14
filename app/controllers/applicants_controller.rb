class ApplicantsController < ApplicationController
  def new; end

  def create
    applicant = Applicant.new(applicant_params)
    applicant.save

    redirect_to "/applicants/#{applicant_params[:id]}"
  end

  private

  def applicant_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
