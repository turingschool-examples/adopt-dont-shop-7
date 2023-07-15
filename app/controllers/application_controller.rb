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

  end

  def choose_shelter_id
    Shelter.first.id
  end

  def create
    @application = Application.new(post_params)
    @application.application_status = 'In Progress'
    @application.created_at = Time.now
    @application.updated_at = Time.now
    @application.shelter_id = choose_shelter_id

    if @application.save
    redirect_to "/applications", notice: "Applications submission success!"
    else
      render :index
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
