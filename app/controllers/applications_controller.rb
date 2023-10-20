class ApplicationsController < ApplicationController
  def index
    @application = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Application.select("pets.name").joins(:pets).pluck(:name)
    
    if params[:search_by_name].present?
      threshold = params[:search_by_name].to_s
      @pets = @pets.where('name = ?', threshold)
    end
  end

  def add_pet_to_application
    @application = Application.find(params[:id])
    @adopted_pet = Pet.find(params[:pet_id])
    @application.pet = @adopted_pet.name
    redirect_to '/applications/:id'
  end

end