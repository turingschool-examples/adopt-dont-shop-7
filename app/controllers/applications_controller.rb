class ApplicationsController < ApplicationController
  def show
    @application = Application.find(params[:id])

    if params[:pet_name].present?
      @matching_pets = Pet.adoptable.where('name ILIKE ?', "%#{params[:pet_name]}%")
    end
  end

  def update
    @application = Application.find(params[:id])
    @application.update(description: params[:description], status: "Pending")
    redirect_to "/applications/#{@application.id}"
  end
end

