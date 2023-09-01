class ApplicationsController < ApplicationController
  def show
    # require 'pry';binding.pry
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new(app_params)
    application.save
    redirect_to "/applications/#{application.id}"
  end

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason_for_adoption, :status)
  end
end