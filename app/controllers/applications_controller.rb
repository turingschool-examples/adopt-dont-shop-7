class ApplicationsController < ApplicationController
  def show
    if params[:search]
      search_for_pet
    else
      @application = Application.find(params[:id])
    end
  end

  def new
  end

  def create
    address = "#{application_params[:street_address]}, city: #{application_params[:city]}, state: #{application_params[:state]}, zip: #{application_params[:zip_code]}"

    if application_params.values.any?(&:blank?)
      flash[:alert] = "All fields are required."
      redirect_to "/applications/new"
      return
    end

    @application = Application.create!(
      name: application_params[:name],
      address: address,
      description: application_params[:description],
      status: "In Progress"
    )

    redirect_to "/applications/#{@application.id}"
  end

  def search_for_pet
      @parameter = params[:search].downcase
      @result = Pet.all.where("lower(name) LIKE :search", search: "%#{@parameter}")
      redirect_to "/applications/#{params[:id]}/"
  end

  private
  def application_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end
