class ApplicantsController < ApplicationController
  def new
  end

  def show
    @applicant = Applicant.find(params[:id])
  end

  def create
    applicant = Applicant.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
    })

    applicant.save
    
    redirect_to "/applicants/#{applicant.id}"
  end
  
end