class ApplicationsController < ApplicationController

  def new; end

  def create 
    new_app = Application.new(app_params)
    if new_app.save
      new_app.update!(status: 0)
      redirect_to "/applications/#{new_app.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      redirect_to  "/applications/new"
    end
  end

  def show
    @app = Application.find(params[:id])
    # @found_pets = @app.found_pets(params[:search_name]) if params[:search_name]
    @found_pets = Pet.search(params[:search_name]) if params[:search_name]
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description)
  end
end