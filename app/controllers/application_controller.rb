class ApplicationController < ActionController::Base
  def welcome
  end

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

  def error_message(errors)
    errors.full_messages.join(', ')
  end
end
