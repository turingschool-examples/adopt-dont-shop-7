class Admin::ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])
    @pets = @application.pets
  end

  def update
    @application = Application.find(params[:id])
    @pets = @application.pets
    if params[:commit].starts_with?('Approve')
      approved_pet = @pets.find_by(adoptable: false)
      approved_pet.update!(adoptable: true, rejected: false) if approved_pet
      redirect_to "/admin/applications/#{@application.id}"
    elsif params[:commit].starts_with?('Reject')
      rejected_pet = @pets.find_by(adoptable: false)
      rejected_pet.update!(adoptable: false, rejected: true) if rejected_pet
      redirect_to "/admin/applications/#{@application.id}"
    end

  end
end
