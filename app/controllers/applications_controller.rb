class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%").all
    end
  end

  def adopt_pet
    @application = Application.find(params[:id])
    @pet = Pet.find(params[:pet_id])

    unless @application.pets.include?(@pet)
      @application.pets << @pet
    end

    redirect_to "/applications/#{params[:id]}"
  end
end

