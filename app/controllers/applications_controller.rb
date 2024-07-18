class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:search_by_name]) if params[:search_by_name].present?
  end

  def new
    @application = Application.new 
  end

  def create
    @application = Application.new(application_params)
    if @application.save
      @application.update({"status" => "In Progress"})
      redirect_to "/applications/#{@application.id}"
    else
      flash[:error] = "You must fill in all fields to submit"
      render :new, { name: @application.name, 
                    street_address: @application.street_address,
                    city:  @application.city,
                    state: @application.state,
                    zip_code: @application.zip_code,
                    description: @application.description }
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update({"status" => "Pending"})
    redirect_to "/applications/#{@application.id}"
  end
  
  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end