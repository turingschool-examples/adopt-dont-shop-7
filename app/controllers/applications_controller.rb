class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def new

  end

  def create
    application = Application.create!(
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      reason_for_adoption: params[:reason_for_adoption],
      status: "In Progress"
    )
    redirect_to "/applications/#{application.id}"
  end
end