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
      render "new"
    end
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def search_pets
    @application = Application.find(params[:id])
    @search_results = @application.search_pets_by_name(params[:name])
    render 'show'
  end
end


private

def application_params
  params.permit(:applicant_name, :address, :city, :state, :zip_code, :description)
end
