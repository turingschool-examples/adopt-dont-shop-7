class PetApplicationsController < ApplicationController

  def create
    applicant = Application.find(params[:id])
    pet_application = PetApplication.create!({
    pet_id: params[:pet_id],
    application_id: params[:id],
    status: "Pending",
    })
  
    redirect_to "/applications/#{applicant.id}"
  end

  def update
    # pet_application = PetApplication.find_by(pet_id: params[:pet_id], application_id: params[:id]).first
    pet_application = PetApplication.find_pet_application(params[:id], params[:pet_id])
    # require 'pry';binding.pry
    pet_application.update!(status: params[:status])
    redirect_to "/admin/applications/#{params[:id]}"
  end
end