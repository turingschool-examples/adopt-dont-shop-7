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
      approved_pet.update(adoptable: true) if approved_pet
      redirect_to "/admin/applications/#{@application.id}"
    end
  end
end
