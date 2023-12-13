class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @application_pets = @application.application_pets.includes(:pet)
    # @pets = @application.pets <--not using pet anymore
  end

  def update
    # we want it to be approved/rejected at application_pets, not change the pets status?
    @application = Application.find(params[:id])
    # @pets = @application.pets
    # @pet = Pet.find(params[:id])
    pet_id = params[:pet_id]
    @application_pet = @application.application_pets.find_by(pet_id: pet_id)
    if params[:commit].starts_with?('Approve')
      # creating the rejected attribute here, is like a different pet object/only in the admin, but I think it still carries back to the pet. we need the link to stay broken
      # approved_pet = @pets.find_by(adoptable: false)
      # approved_pet.update!(adoptable: true, rejected: false) if approved_pet
      @application_pet.update!(status: "Accepted")
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:commit].starts_with?('Reject')
      # no need to make a different pet object now
      # rejected_pet = @pets.find_by(adoptable: false)
      # rejected_pet.update!(adoptable: false, rejected: true) if rejected_pet
      @application_pet.update!(status: "Rejected")
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end
