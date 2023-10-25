class ApplicationsController < ApplicationController

  def new

  end

  def create
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

end