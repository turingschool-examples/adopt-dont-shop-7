class ApplicationsController < ApplicationController

  def new

  end

  def create
    
  end
  
  def show
    require 'pry'; binding.pry
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pet = @application.search(params[:name])
    end
  end

end