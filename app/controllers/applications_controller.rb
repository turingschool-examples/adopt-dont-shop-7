class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @matching_pets = Pet.adoptable.where('name ILIKE ?', "%#{params[:pet_name]}%")
    end
  end
end

