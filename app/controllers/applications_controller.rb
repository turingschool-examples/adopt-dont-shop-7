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
    @found_pets = Pet.search(params[:search_name]) if params[:search_name]
  end

  def update
    @app = Application.find(params[:id])
    if params[:reason_to_adopt]
      @app.update!(status: 1)
    end
    redirect_to "/applications/#{@app.id}"
  end

  private

  def app_params
    params.permit(:name, :street_address, :city, :state, :zip, :description, :reason_to_adopt, :status)
  end
end