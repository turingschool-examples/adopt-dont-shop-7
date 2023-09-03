class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @matching_pets = Pet.where('name LIKE ?', "%#{params[:pet_name]}%").all
    end
  end
end

