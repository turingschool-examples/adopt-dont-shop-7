class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end
  
  def new
    @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"   
    else
      flash[:alert] = "Please fill in all required fields"
      redirect_to "/applications/new"
      # puts @application.errors.full_messages
      # render "new"
    end
  end

  def show
        @applicant = Application.find(params[:id])
        @pets = @applicant.pets
  end
end

private

def application_params
  params.permit(:applicant_name, :address, :city, :state, :zip_code, :description)
end
