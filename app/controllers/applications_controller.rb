class ApplicationsController < ApplicationController
  def show 
    @application = Application.find(params[:id])
  end

  def new

  end

  def create
    application = Application.create(application_params)
    redirect_to "/applications/#{application.id}"
  end

  private
    def application_params
      full_addr = "#{params[:addr]}, #{params[:city]}, #{params[:state]}, #{params[:zip]}"
      params.permit(:name, :description).merge(address: full_addr, status: "In Progress")
    end
end