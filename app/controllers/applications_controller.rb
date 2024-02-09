class ApplicationsController < ApplicationController
  def new
    @application = Application.new
  end

  def create
    application = Application.new(application_params)

    if application.save
      redirect_to "/applications/#{application.id}"
    else
      flash[:notice] = application.errors.full_messages.join(', ')
      redirect_to "/applications/new"
    end
  end

  def show
    @application = Application.find(params[:id])
    if params[:pet_name]
      @pets = Pet.search(params[:pet_name])
    end
  end

  private
  def application_params
    params.require(:application).permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
