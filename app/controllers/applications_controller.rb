class ApplicationsController < ApplicationController

  def show
      @application = Application.find(params[:id])
    if params[:search]
      @result = @application.search_for_pet(params[:search])
    end
  end

  def new
  end

  def create
    address = "#{application_params[:street_address]}, city: #{application_params[:city]}, state: #{application_params[:state]}, zip: #{application_params[:zip_code]}"
    if application_params.values.any?(&:blank?)
      flash[:alert] = "All fields are required."
      redirect_to "/applications/new"
      return
    end

    @application = Application.create!(
      name: application_params[:name],
      address: address,
      description: application_params[:description],
      status: "In Progress"
      )
    redirect_to "/applications/#{@application.id}"
  end

  def update
    if params[:reason]
      @application = Application.find(params[:id])
      @application.update!(description: params[:reason], status: "Pending")
      redirect_to "/applications/#{@application.id}"
    end
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
