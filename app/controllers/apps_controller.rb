class AppsController < ApplicationController
  
  def index
    @apps = App.all
  end
  
  def new
    @app = App.new

  end

  def show
    @app = App.find(params[:id])
    params[:search].present?
  end

  def create
    app = App.new(app_params)
    if app.save
      redirect_to "/apps/#{app.id}"
    else
      flash[:alert] = "Error: Please fill out all fields"
      render :new
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
  
  private
  def app_params
    params.permit(:name, :address, :city, :state, :zip, :description)
  end
end