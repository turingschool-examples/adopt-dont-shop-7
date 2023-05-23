class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = if params[:search].present?
              Pet.search(params[:search])
            else
              []
            end
  end

  def new; end

  def create
    application = Application.new(application_params)
    if application.save
      flash[:alert] = nil
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: #{error_message(application.errors)}"
      render :new
    end
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip, :description_why)
  end
end
