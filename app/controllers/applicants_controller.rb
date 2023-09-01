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

    if applicant.save
      redirect_to "/applications/#{applicant.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(applicant.errors)}"
    end


  end
  
end