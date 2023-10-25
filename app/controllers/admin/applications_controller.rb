class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:application_id])
    @pets = @application.pets
  end

  def update
    application = Application.find(params[:application_id])
    selected_pet = Pet.find(params[:pet_id])
    if params[:approved?] == "Yes"
      application.update(status: 2)
      selected_pet.update(adoptable: false)
    elsif params[:approved?] == "No"
      application.update(status: 3)
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end