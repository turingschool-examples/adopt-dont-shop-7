class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:app_id])
  end

  def create
    application = Application.new({
      id: params[:id],
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      description: params[:description],
      status: "In Progress"
      })
  
    application.save
  
    redirect_to "/applications/#{application.id}"
  end
end