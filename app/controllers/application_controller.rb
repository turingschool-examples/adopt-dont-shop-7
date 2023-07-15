class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @applications = Application.all.order("name")
  end

  def show
    @application = Application.find(params[:id])
    # @pet = Pet.find(@application.pet_applications[0].pet_id)
  end

  def new
    # @application = Application.new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end

    def application_params
      params.permit(:name, :street_address, :city, :state, :zip, :description).merge(status: "In Progress")
    end
end

