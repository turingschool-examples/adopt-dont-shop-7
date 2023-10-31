class ApplicationsController < ApplicationController

  def new

  end

  def create
    application = Application.new({
      name: params["name"],
      street_address: params["Street Address"],
      city: params["City"],
      state: params["State"],
      zip_code: params["Zip Code"],
      description: params["Description"],
      application_status: "In Progress"
    })

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:alert] = "All fields must be filled in before you can proceed"
      redirect_to "/applications/new"
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
    @application.update({ description: params[:why_good_owner], application_status: "Pending" })

    redirect_to "/applications/#{@application.id}"
  end

end