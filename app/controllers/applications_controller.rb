class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new(application_params)
    require 'pry'; binding.pry

    if application.save      
      require 'pry'; binding.pry

      redirect_to "/applications/#{application.id}"   
    else
      require 'pry'; binding.pry

      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private
    def application_params
      params.permit(:name, :street, :city, :state, :zip, :description, :status)
    end
 
end
