class ApplicationsController < ApplicationController
  def new
  end

  def create
    application = Application.create({
      name: params[:name],
      address: params[:address],
      address_s: params[:address_s],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      description: params[:description],
      status: "In Progress"
    })

    redirect_to "/applications/#{application.id}/show"
  end

  def id
    params[:id]
  end

  def show
    @app = Application.find(id)
  end
end
