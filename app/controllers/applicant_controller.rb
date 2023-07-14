class ApplicantController < ApplicationController
  def show
    @applicant = Applicant.find(params[:id])
  end
end