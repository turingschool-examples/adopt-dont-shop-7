class ApplicationController < ActionController::Base
  def welcome
  end

  def index
    @applications = Application.all.order("name")
  end

  def show
    if params[:pet_name].present?
      @application = Application.find(params[:id])
      @pets = Pet.search(params[:pet_name])
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      render :new
    end
  end

  def submit
    @application = Application.find(params[:id])
    @application.update(status: "Pending")
    redirect_to "/applications/#{@application.id}"
  end

  private

    def error_message(errors)
      errors.full_messages.join(', ')
    end

    def application_params
      params.permit(:name, :street_address, :city, :state, :zip, :description).merge(status: "In Progress")
    end
end

