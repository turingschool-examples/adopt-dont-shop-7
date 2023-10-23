class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end

  def update
    @application = Application.find(params[:application_id])
    selected_pet = Pet.find(params[:pet_id])
    require 'pry'; binding.pry
    if params[:approved?] == "Yes"
      approve(selected_pet)
    end
    if params[:approved?] == "No"
      reject(selected_pet)
    end
    @application.update(status: 2)
    redirect_to "/admin/applications/#{@application.id}"
  end
end