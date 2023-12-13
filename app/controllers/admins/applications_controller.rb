class Admins::ApplicationsController < ApplicationController

  def show
    @application = Application.application(params[:id])
    if params[:filter] == "approved"
      pet_application = ApplicationPet.approve_or_deny(params[:pet_id], params[:id], params[:filter])
      Pet.find(params[:pet_id]).set_adoptable_false #is this chaining too much? I figured it's the same thing as: pet = Pet.find(params[:pet_id] -> pet.set_adoptable_false)
    elsif params[:filter].present?
      pet_application = ApplicationPet.approve_or_deny(params[:pet_id], params[:id], params[:filter])
    end
  end
end
