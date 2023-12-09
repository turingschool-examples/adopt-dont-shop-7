class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    input_params = application_params
    address = "#{input_params[:street_address]}, city: #{input_params[:city]}, state: #{input_params[:state]}, zip: #{input_params[:zip_code]}"

    if input_params.values.any?(&:blank?)
      flash[:alert] = "All fields are required."
      redirect_to "/applications/new"
      return
    end

    @application = Application.create!(
      name: input_params[:name],
      address: address,
      description: input_params[:description],
      status: "In Progress"
    )
  end

    private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
