class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new({
      name: params[:name],
      full_address: create_full_address(params),
      description: params[:description],
      status: "Pending"
    })

    application.save

    redirect_to "/applications/#{application.id}"
  end

  private

  def create_full_address(params)
    "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}"
  end

end