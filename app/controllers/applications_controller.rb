class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:search].present? 
      @pet_search_results = Pet.search_by_name(params[:search])
      # require 'pry'; binding.pry
    else
      @pet_search_results = []
    end
  end

  def new

  end

  def create
    application = Application.new(application_params)
      if application.save
        redirect_to "/applications/#{application.id}"
      else
        redirect_to "/applications/new"
        flash[:alert] = "Error: #{error_message(application.errors)}"
      end
  end

  def update
    application = Application.find(params[:id])

    if application.update(application_params)
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  private
  def application_params
    params.permit(:id, :name, :street, :city, :state, :zip_code, :status, :description, :reason)
  end
  

end