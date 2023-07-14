class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    if params[:id] == "new"
      @application = Application.new
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
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