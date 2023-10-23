class ApplicationsController < ApplicationController
  def new

  end

  def create
    
  end
  
  def show
    @application = Application.find(params[:id])
    @pet = Application.find_pet_by_name(params[:name])
    require 'pry'; binding.pry
  end

end