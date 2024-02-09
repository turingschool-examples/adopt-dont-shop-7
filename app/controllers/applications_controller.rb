class ApplicationsController < ApplicationController
  def show 
    @app = Application.find(params[:id]) 
    @pets = @app.pets
    if params[:search]
      require 'pry'; binding.pry
      @found_pets = Pet.search(params[:search])
    end
  end 

  def new; end

  def create
    new_app = Application.new(strong_params)
    if new_app.save
      redirect_to "/applications/#{new_app.id}"
    else 
      flash[:notice] = "Missing required inputs"
      redirect_to "/applications/new"
    end 
  end

  private 

  def strong_params
    params.permit(:name,
                  :street_address,
                  :city, 
                  :state,
                  :zip,
                  :description)
  end
end 