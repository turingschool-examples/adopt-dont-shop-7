class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def new 
  end

  def create 
    @app = Application.new(application_params)
    if @app.save
      redirect_to "/applications/#{@app.id}"
    else 
      flash[:error] = "Error: All fields must be filled in to submit"
      redirect_to "/applications/new"
    end
  end

  private

  def application_params
    params.permit(:id, :applicant_name, :street_address, :city, :state, :zip_code, :description, :status)
  end
end
