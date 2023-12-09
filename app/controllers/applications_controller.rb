class ApplicationsController < ApplicationController
  def index

  end

  def new

  end

  def create
    @application = Application.new(application_params)
    @application.set_status_in_progress
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: All fields are required." # Is this the correct location? Or should we move this error message text to application_controller.rb or another file?
    end
  end

  def edit

  end

  def update

  end

  def show
    @application = Application.find(params[:id])
    @application.set_status_pending
  end

  def destroy

  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description, :good_owner_comments)
  end
end
