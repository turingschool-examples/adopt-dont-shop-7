class ApplicationsController < ApplicationController

  def new
  end

  def create
    application = Application.new(application_params)
    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "Please fill in all required fields"
      # flash[:alert] = "Error: #{error_message(@application.errors)}"
      redirect_to "/applications/new"
      # render :new
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets_search = Pet.search(params[:pet_name])
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update({ description: :why_good_owner, application_status: "Pending" })

    redirect_to "/applications/#{@application.id}"
  end

  private

  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end

end