class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
  end
  def update
    pet = Pet.find(params[:pet_id])
    pet.update(adoptable: false)
    approval = ApplicationPet.where(pet_id: pet.id).where(application_id: params[:id])
    approval.update(approved: true)
    redirect_to "/admin/applications/#{params[:id]}"
  end

end