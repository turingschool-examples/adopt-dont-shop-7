class ApplicationsController < ApplicationController

  def show
    @application = Application.find(params[:id])
    if params[:search].present? 
      @pets = Pet.search(params[:search])
    end
  end

  def new
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:error] = "Please Fill Out Entire Form"
    end
  end

  def update
    application = Application.find(params[:id])
    if params[:good_owner] == nil
      pet = Pet.find(params[:pet_id])
    else 
      application.update(status: "Pending")
      application.save
    end
    redirect_to "/applications/#{application.id}"
  end

  private

  def application_params
    params.permit(:name, :address, :city, :state, :zip_code, :description, :status)
  end
end