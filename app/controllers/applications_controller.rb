class ApplicationsController < ApplicationController
    
  def show
    @app=Application.find(params[:id])
  end

  
  
  
  def new 
  end

  def create
    application = Application.new({
      name: params[:name],
      address: params[:address],
      city: params[:city],
      state: params[:state],
      zipcode: params[:zipcode],
      description: params[:description],
      status: params[:status]
    })
     #binding.pry
    if application.save
      #redirect_to "/applications/#{application.id}"
      redirect_to "/applications/new"
    else
      flash.alert = "Each field must be complete"
      render :new
    end
  end


  private 
  def id
    params[:id]
  end
end