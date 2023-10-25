class ApplicationsController < ApplicationController

  def new

  end

  def create
  end

  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:pet_name]
      @pets_search = Pet.search(params[:pet_name])
    end
  end

  def update
    application = Application.find(params[:id])
    application.update(status: 1)
    application.update(description: params[:why_good_owner])
  end

end