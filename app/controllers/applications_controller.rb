class ApplicationsController < ApplicationController
  def index
    @num_of_applications = Application.all.num_of_applications
  end

  def show
    @application = Application.find(params[:id])
    @pets = Pet.search(params[:add_pet_name])
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
    Application.find(params[:id]).update(adopting_reason:params[:adopting_reason])
    redirect_to "/applications/#{params[:id]}"
  end

  private
    def applications_params
      params.permit( :name, :street_address, :city, 
      :state, :zip_code, :adopting_reason )
    end
end