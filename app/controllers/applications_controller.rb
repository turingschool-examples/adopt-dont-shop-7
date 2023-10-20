class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.new({
      name: params[:name],
      full_address: "#{params[:street_address]}, #{params[:city]}, #{params[:state]}, #{params[:zip_code]}",
      description: params[:description],
      status: "Pending"
    })

    application.save

    redirect_to "/applications/#{application.id}"
  end

  # private

end