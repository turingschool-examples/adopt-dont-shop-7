class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    Application.create(application_params)
    redirect_to "/applications/#{Application.last.id}"    
  end

  private
    def application_params
      params.permit(:name, :street, :city, :state, :zip, :description, :status)
    end
 
end
