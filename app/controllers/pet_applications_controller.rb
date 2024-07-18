class PetApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id]) 
    @pet_application = PetApplication.find(params[:id])
  end

  def create 
    PetApplication.create(application_id: params[:id], pet_id: params[:pet_id])

    redirect_to "/applications/#{params[:id]}"
  end

  def edit

  end

  def update
    application = Application.find(params[:id])
    application.update({id: params[:id], name: params[:name], street_address: params[:street_address], city: params[:city], state: params[:state], zip_code: params[:zip_code], description: params[:description]})
    redirect_to "/applications/#{application.id}"
  end
end