class ApplicationsController < ApplicationController
  def show
    require "pry"
    binding.pry
    @application = Application.find(params[:id])
  end

  def new
  end

  def create
    application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      pets: [],
      status: "In Progress"
    })

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Error: You must fill in all fields"
      render :new
    end
  end
end
