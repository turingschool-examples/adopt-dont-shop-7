class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
  
  def update
    pet = Pet.find(params[:pet_id])
    approval = ApplicationPet.where(pet_id: pet.id).where(application_id: params[:id])
    if params[:confirm] == "approve"
      pet.update(adoptable: false)
      approval.update(approved: "approved")
    elsif params[:confirm] == "reject"
      pet.update(adoptable: true)
      approval.update(approved: "rejected")
    end
    redirect_to "/admin/applications/#{params[:id]}"
  end
end