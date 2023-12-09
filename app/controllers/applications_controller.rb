class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    @pets = @application.pet_search(params[:pet_name])
  end

  def new 

  end

  def create 
    application = Application.create!({
      name: params[:name],
      street: params[:street],
      city: params[:city],
      state: params[:state],
      zip: params[:zip],
      descr: params[:good_owner]
    })
    
    redirect_to "/applications/#{application.id}"
  end
end