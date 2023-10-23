class AppsController < ApplicationController
  
  def index
    @apps = App.all
  end
  
  def new
    @app = App.new
  end

  def show
    @app = App.find(params[:id])
    # require 'pry'; binding.pry
    if params[:search].present?
      @matching_pets = Pet.adoptable_search(params[:pet_name])
    end
  end

  def create
    app = App.create(app_params)
    redirect_to "/apps/#{app.id}"
  end

  def update
    # require 'pry'; binding.pry
    @app = App.find(params[:id])
    @pet = Pet.find(params[:pet_id])
    # require 'pry'; binding.pry
    @app.pets << @pet
    redirect_to "/apps/#{params[:id]}"
  end

  def add_pet

    @app = App.find(params[:app_id])
    @pet = Pet.where(name: params[:query]).first
    @app.pets << @pet

    redirect_to "/apps/#{@app.id}"
  end
  
  private
  def app_params
    params.permit(:name, :address, :city, :zip, :description, status: "In Progress")
  end
end