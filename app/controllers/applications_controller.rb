class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.create({
      name: params[:name],
      street_address: params[:street_address],
      address_s: params[:address_s]
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      status: "In Progress"
    })

    redirect_to "/applications/#{application.id}"
  end
end