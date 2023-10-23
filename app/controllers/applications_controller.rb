class ApplicationsController < ApplicationController
  def new
  end

  def show
    # require'pry';binding.pry
    @application = Application.find(params[:id])
  end

  def create
    @application = Application.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      application_status: params[:application_status]
    })
    
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def update
    
  end
end