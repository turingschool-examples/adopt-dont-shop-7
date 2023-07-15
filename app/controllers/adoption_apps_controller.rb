class AdoptionAppsController < ApplicationController
  def show
    @adoption_app = AdoptionApp.find(params[:id])
  end

  def new
    # @adoption_app = AdoptionApp.find(params[:id])
  end

  def create
    created = "In Progress"
    new_app = AdoptionApp.new({
      name: params[:name],
      street_address: params[:street_address],
      city: params[:city],
      state: params[:state],
      zip_code: params[:zip_code],
      description: params[:description],
      pet_names: params[:pet_names],
      status: created
    })

    if new_app.save    
    redirect_to "/adoption_apps/#{new_app.id}"
    else
      flash[:notice] = "Application not created: Required information missing."
      render :new
    end
  end

  private
  def adoption_app_params
    params.permit(:name, :street_address, :city, :state, :zip_code, :description)
  end
end