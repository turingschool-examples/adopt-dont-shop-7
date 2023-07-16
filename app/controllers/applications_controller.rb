class ApplicationsController < ApplicationController

  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
  end

  def new
    @application = Application.new
  end

  def choose_shelter_id
    Shelter.first.id
  end

  def create
    @application = Application.new(post_params)
    @application.shelter_id = choose_shelter_id
    @application.application_status = "In Progress"
    if @application.save
      redirect_to action: 'index'
    else
      flash[:error] = "Error: #{error_message(@application.errors)}"
      redirect_to "/applications/new"
    end
  end

  private

  def post_params
    params.permit(:name_of_applicant, :street_address, :city, :state, :zip_code, :description, :shelter_id)
  end
end