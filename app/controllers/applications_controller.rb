class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
    @search_results = params[:search]
    @results = Pet.search(params[:search])
  end

  def new

  end

  def create
    application = Application.new(app_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      redirect_to "/applications/new"
      flash[:alert] = "Error: #{error_message(application.errors)}"
    end
  end

  def update
    application = Application.find(params[:id])
    if params[:reason_for_adoption].empty?
      redirect_to "/applications/#{application.id}"
      flash[:alert] = "Please input why you would be a good home"
    else
      application.update(
        status: "Pending",
        reason_for_adoption: params[:reason_for_adoption]
      )
      redirect_to "/applications/#{application.id}"
    end
  end


  def app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :reason_for_adoption, :status)
  end
end