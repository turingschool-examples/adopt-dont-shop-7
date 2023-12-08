class ApplicationsController < ApplicationController
  def index

  end

  def new

  end

  def create
    @application = Application.new(application_params)
    @application.save
    redirect_to "/applications/#{@application.id}"
  end

  def edit

  end

  def update

  end

  def show
    @application = Application.find(params[:id])
  end

  def destroy

  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zipcode, :description)
  end
end
