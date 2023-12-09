class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    input_params = application_params
    address = "#{input_params[:street_address]}, city: #{input_params[:city]}, state: #{input_params[:state]}, zip: #{input_params[:zip_code]}"

    @application = Application.create!(
      name: input_params[:name],
      address: address,
      description: input_params[:description],
      status: "In Progress"
    )

    redirect_to "/applications/#{@application.id}"
  end

    private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
