class ApplicantsController < ApplicationController
  def index

  end
  
  def show
    @applicant = Applicant.find(params[:id])
    # @pets = Pet.find(params[:id])
  end

  def new
    
  end
end