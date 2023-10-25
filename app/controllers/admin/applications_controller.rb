class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end

  def update
    application = Application.find(params[:id])
    require 'pry'; binding.pry
    pet_app = PetApplication.find(params[:application_id])
    pet = pet_app
    if params[:commit] == "Approve"
      pet_app.update(adoption_approved: true)
    elsif params[:commit] == "Reject"
      pet_app.update(adoption_approved: false)
    end
    redirect_to "/admin/applications/#{application.id}"
  end
end

