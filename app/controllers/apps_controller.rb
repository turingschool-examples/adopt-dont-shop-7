class AppsController < ApplicationController
  
  def index
    @apps = App.all
  end
  
  def new
    @app = App.new
  end

  def show
    @app = App.find(params[:id])
    if params[:search].present?
      @matching_pets = Pet.adoptable_search(params[:pet_name])
    end
  end

  def create
    app = App.create(app_params)
    if app.save
      redirect_to "/apps/#{app.id}"
    else
      redirect_to "/apps/"
      flash[:alert] = "Error: Please fill out this field}"
    end
  end

  def update
    @app = App.find(params[:id])
    if !params[:good_owner].present?
      @pet = Pet.find(params[:pet_id])
      @app.pets << @pet
    else 
      @app.update(status: 1)
    end
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
    params.permit(:name, :address, :city, :zip, :description)
  end
end