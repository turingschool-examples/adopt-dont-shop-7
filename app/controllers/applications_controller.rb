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

  def create
    @application = Application.create(application_params)
    redirect_to "/applications/#{@application.id}"
  end

  private
    def application_params
      params.permit(
        :name, 
        :street_address, 
        :city, 
        :state, 
        :zipcode, 
        :description, 
        :status
        )
    end
end