class ApplicationsController < ApplicationController
  def index
    @applications = Application.all
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:add_pet_name]) 
    @pet_added = params[:adopt] == 'true'
    @app_submitted = @application.status != "In Progress" 
  end

  def new
  end

  def create
    @application = Application.new(applications_params)

    if @application.save
      @application.update(status: "In Progress")
      redirect_to "/applications/#{@application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(@application.errors)}"
    end
  end

  def update 
    Application.find(params[:id]).update(
      adopting_reason:params[:adopting_reason],
      status: "Pending"
      )
    
    redirect_to "/applications/#{params[:id]}"
  end

  def destroy
    Application.find(params[:id]).destroy
    redirect_to "/applications"
  end

  private
    def applications_params
      params.permit( :name, :street_address, :city, 
      :state, :zip_code, :adopting_reason )
    end
end